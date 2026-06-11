# kxi-sp Chart

## Description

This chart deploys the Insights SP component, a high-performance, scalable, flexible stream processing system implemented in q. This chart is deployable independently of InsightsDB.

## Running on Kubernetes

### Prerequisites

1. A working Kubernetes cluster with appropriate access to deploy applications
1. `helm` command installed on your local machine
1. Authentication details to Kx image repositories

    ```bash
    KX_USER=....
    KX_PASS=....
    KX_REGISTRY="portal.dl.kx.com"
    NAMESPACE="kxi-sdk"
    ```

1. `imagePullSecrets` setup on your cluster

    ```bash
    kubectl create secret docker-registry kx-pull-secret --docker-username=$KX_USER --docker-password=$KX_PASS --docker-server=$KX_REGISTRY -n $NAMESPACE
    ```

1. A license secret

    _Contact KX to get a license_

    ```bash
    LIC_FILE=./kc.lic
    kubectl create secret generic kx-license --from-file=license=$LIC_FILE -n $NAMESPACE
    ```

1. A deployment specific values file (`myvalues.yaml`) with configurations relative to your deployment. Available configurations are documented in the chart. This can be displayed by running

    ```bash
    # Run from kxCharts/kxi-sp directory
    helm show values .
    ```

    A minimum `myvalues.yaml` configuration would contain

      ```yaml
      imagePullSecrets:
      - name: kx-pull-secret

      # -- You must set your license name. Default is `"kc.lic"`.
      # Available types are:
      #  - `"kc.lic"`
      #  - `"k4.lic"`
      #  - `"kx.lic"`
      kxLicenseName: "kc.lic"
      ```

### Deploying

```bash
# Run from '.../kxCharts/kxi-sp' directory
RELEASENAME=my-sp # Unique name for this deployment
VALUESFILE=myvalues.yaml
NAMESPACE="kxi-sdk"
helm install $RELEASENAME . -f $VALUESFILE -n $NAMESPACE
```

Note: If `$RELEASENAME` is set as `kxi-sp` resources will be named `kxi-sp`, using the `helm` default `fullname` template.

### Upgrading/updating config

Upgrading and updating configuration are executed using `helm upgrade`. This will deploy any changes made to the charts or configuration since the last deploy and automatically redeploy the latest to the application

```bash
helm upgrade $RELEASENAME . -f $VALUESFILE -n $NAMESPACE
```

Connecting
===========

You can communicate with the Coordinator from outside the cluster using the kubectl port-forward command.

  ```bash
  kubectl port-forward svc/my-sp-kxi-sp 5000:5000
  ```

Deploying pipelines
===================

Once you have port-forwarded, you can create pipelines by issuing HTTP POST requests using a similar command to the example below, given you have a pipeline specification stored in a local q file called `spec.q`.

```bash
curl -X POST http://localhost:5000/pipeline/create -d \
        "$(jq -n --arg spec "$(cat < spec.q)" \
        '{
            name     : "sp-example",
            type     : "spec",
            config   : { content: $spec },
            settings : { maxWorkers: "10" }
         }' | jq -asR .)"
```

Destroying pipelines
====================

Pipelines can be removed from the cluster with the following REST API.

```bash
curl -X POST "localhost:5000/pipeline/teardown/<pipeline-id>"
```

Further information about writing and deploying pipelines, including a Quickstart walkthrough, can be found in the kdb [Insights Stream Processor documentation](https://code.kx.com/insights/microservices/stream-processor/index.html).

## Configuration Options

### Local Configurations

Local values configuration for `kxi-sp`.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| `affinity` | `object` | <code>{}</code> | This is for setting Kubernetes Affinity to a Pod.<br>Refer to [Pod Affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity). |
| `args` | `list` | <code>[<br/>&nbsp;&nbsp;"-kube",<br/>&nbsp;&nbsp;"-g",<br/>&nbsp;&nbsp;"1",<br/>&nbsp;&nbsp;"-p",<br/>&nbsp;&nbsp;"5000"<br/>]</code> | Can provide any valid `q` runtime argument here.<br>Full details [here](https://code.kx.com/q/basics/cmdline/).<br>**NOTE** the `-p` argument will be overridden by the `KXI_PORT` env variable. |
| `env` | `list` | <code>[]</code> | Setup Environment variables here for the SP container. |
| `fullnameOverride` | `string` | <code>""</code> | Override the default fully qualified app name.<br>By default resources are named using `<.Release.Name>-<.Chart.Name>`.<br>Used when generating resource names. |
| `image` | `object` | <code>{}</code> | Default image repository and pull settings for SP chart components.<br>Refer to [Images](https://kubernetes.io/docs/concepts/containers/images/). |
| `image.component` | `string` | <code>".Chart.Name"</code> | Image component. |
| `image.pullPolicy` | `string` | <code>"IfNotPresent"</code> | Image pull policy.<br>Refer to [Image Pull Policy](https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy). |
| `image.repository` | `string` | <code>"portal.dl.kx.com/"</code> | Image repository. |
| `image.tag` | `string` | <code>".Chart.AppVersion"</code> | Image tag. |
| `imagePullSecrets` | `list` | <code>[]</code> | Image pull secrets to be applied to all pods within the chart.<br>For pulling an image from a private repository.<br>Refer to [Image Pull Secrets](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/). |
| `kxLicenseName` | `string` | <code>"kc.lic"</code> | You must set your license name.<br>Available types are:  - `"kc.lic"`  - `"k4.lic"`  - `"kx.lic"` |
| `kxiSidecar` | `object` | <code>{}</code> | Default Sidecar configuration for SP components |
| `kxiSidecar.image` | `object` | <code>{}</code> | This sets overriding container image information.<br>Use if you wish to target specific versions of the kxiSidecar.<br>More information can be found [here](https://kubernetes.io/docs/concepts/containers/images/). |
| `kxiSidecar.image.tag` | `string` | <code>"1.18.1"</code> | Image tag. |
| `livenessProbe` | `object` | <code>{}</code> | Configure Liveness Probe for chart.<br>Refer to [Configure Probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/). |
| `livenessProbe.httpGet` | `object` | <code>{}</code> | Defines a probe of type `"httpGet"`. |
| `livenessProbe.httpGet.path` | `string` | <code>"/"</code> | Path to access on the HTTP server. |
| `livenessProbe.httpGet.port` | `int` | <code>5000</code> | Name or number of the port to access on the container. |
| `nameOverride` | `string` | <code>""</code> | Override Chart name.<br>Used when generating resource names. |
| `nodeSelector` | `object` | <code>{}</code> | Allows adding node selector constraints to a Pod.<br>This constrains the pods to run only on nodes that match the specified labels.<br>Dictionary of key-value pairs.<br>Refer to [NodeSelector](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector). |
| `persistence.enabled` | `bool` | <code>false</code> | Enable persistence within release. |
| `podAnnotations` | `object` | <code>{}</code> | Custom annotations to be applied to Pod resources.<br>Dictionary of key-value pairs.<br>Refer to [Object Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/). |
| `podLabels` | `object` | <code>{}</code> | Custom labels to be applied to Pod resources.<br>Dictionary of key-value pairs.<br>Refer to [Object Labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/). |
| `podSecurityContext` | `object` | <code>{}</code> | Pod Level Security Context - Configure the Pod Security Context.<br>Refer to [Pod Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod). |
| `readinessProbe` | `object` | <code>{}</code> | Configure Readiness Probe for chart.<br>Refer to [Configure Probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/). |
| `readinessProbe.httpGet` | `object` | <code>{}</code> | Defines a probe of type `"httpGet"`. |
| `readinessProbe.httpGet.path` | `string` | <code>"/"</code> | Path to access on the HTTP server. |
| `readinessProbe.httpGet.port` | `int` | <code>5000</code> | Name or number of the port to access on the container. |
| `replicaCount` | `int` | <code>1</code> | This sets the `replicaSet` count.<br>More information can be found [here](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/). |
| `resources` | `object` | <code>{}</code> | Resource Coordinator Kubernetes resources.<br>Refer to [Container Resources](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/). |
| `securityContext` | `object` | <code>{}</code> | Container Level Security Context - Configure the Container Security Context.<br>Refer to [Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container). |
| `service` | `object` | <code>{}</code> | Provisions the Kubernetes Service required to expose the workloads.<br>This is for setting up a service more information can be found [here](https://kubernetes.io/docs/concepts/services-networking/service/). |
| `service.port` | `int` | <code>5000</code> | Set exposed Service Port.<br>Refer to [Service Ports](https://kubernetes.io/docs/concepts/services-networking/service/#field-spec-ports). |
| `service.type` | `string` | <code>"ClusterIP"</code> | This sets the Service type.<br>Setting the type field to `LoadBalancer` provisions a load balancer for your Service.<br>The actual creation of the load balancer happens asynchronously, and information about the provisioned balancer is published in the Service's `.status.loadBalancer`.<br>More information can be found [here](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types). |
| `serviceAccount` | `object` | <code>{}</code> | Configure `ServiceAccount` to be used within chart.<br>Refer to [Service Accounts](https://kubernetes.io/docs/concepts/security/service-accounts/). |
| `serviceAccount.annotations` | `object` | <code>{}</code> | Custom annotations to add to the Service Account.<br>Dictionary of key-value pairs.<br>Refer to [Object Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/). |
| `serviceAccount.autoMount` | `bool` | <code>true</code> | Automatically mount a Service Account's API credentials. |
| `serviceAccount.create` | `bool` | <code>true</code> | Specifies whether a Service Account should be created. |
| `serviceAccount.name` | `string` | <code>""</code> | The name of the Service Account to use.<br>If not set and create is `true`, a name is generated using the fullname template. |
| `tolerations` | `list` | <code>[]</code> | This is for setting Kubernetes Tolerations to a Pod This allows the pods to be scheduled on nodes with matching taints.<br>Refer to [Taint and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/). |
| `volumeMounts` | `list` | <code>[]</code> | Additional volumeMounts on the output Deployment definition. |
| `volumes` | `list` | <code>[]</code> | Additional volumes on the output Deployment definition. |

