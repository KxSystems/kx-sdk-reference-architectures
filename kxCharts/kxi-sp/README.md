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
      
      # You must set your license name. Default is 'kc.lic'
      # Available types are:
      #  - kc.lic
      #  - k4.lic
      #  - kx.lic
      kxLicenseName: kc.lic
      ```


### Deploying

```bash
# Run from '.../kxCharts/kxi-sp' directory
RELEASENAME=my-sp # Unique name for this deployment
VALUESFILE=myvalues.yaml
NAMESPACE="kxi-sdk"
helm install $RELEASENAME . -f $VALUESFILE -n $NAMESPACE
```
Note: Please do not use `kxi-sp` as release name 

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
