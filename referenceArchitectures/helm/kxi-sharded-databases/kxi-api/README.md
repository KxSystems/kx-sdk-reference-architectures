# kxi-api

A Helm chart for API access services of a Sharded Database deployment

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../../../../kxCharts/kxi-gw | kxi-gw | 1.19.3 |
| file://../../../../kxCharts/kxi-sp | kxi-sp | 1.19.3 |

## Configuration Options

### Subchart configuration

Configuration for subcharts of `kxi-api`.

#### kxi-gw

Configuration for the `kxi-gw` Subchart.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| `kxi-gw.fullnameOverride` | `string` | <code>""</code> | This sets the full name of the InsightsGW deployment.<br>Override the default fully qualified app name.<br>By default resources are named using `<.Release.Name>-<.Chart.Name>`.<br>Used when generating resource names. |
| `kxi-gw.image` | `object` | <code>{}</code> | Default image repository and pull settings for Insights Gateway chart components.<br>Refer to [Images](https://kubernetes.io/docs/concepts/containers/images/). |
| `kxi-gw.image.pullPolicy` | `string` | <code>"IfNotPresent"</code> | Image pull policy.<br>Refer to [Image Pull Policy](https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy). |
| `kxi-gw.image.repository` | `string` | <code>"portal.dl.kx.com/"</code> | Image repository. |
| `kxi-gw.imagePullSecrets` | `list` | <code>[]</code> | Image pull secrets to be applied to all pods within the chart.<br>For pulling an image from a private repository.<br>Refer to [Image Pull Secrets](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/). |
| `kxi-gw.imagePullSecrets[0].name` | `string` | <code>"kx-pull-secret"</code> |  |
| `kxi-gw.kxLicenseName` | `string` | <code>"kc.lic"</code> | You must set your license name.<br>Default is `"kc.lic"`.<br>Available types are:  - `"kc.lic"`  - `"k4.lic"`  - `"kx.lic"` |
| `kxi-gw.kxiAgg.affinity` | `object` | <code>{}</code> | Allows adding affinities to the Aggregator.<br>Refer to [Pod Affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity). |
| `kxi-gw.kxiAgg.args` | `list` | <code>[]</code> | Can provide any valid `q` runtime argument here.<br>Full details [here](https://code.kx.com/q/basics/cmdline/).<br>**NOTE** the `-p` argument will be overridden by the `KXI_PORT` env variable. |
| `kxi-gw.kxiAgg.customCode` | `object` | <code>{}</code> | Allows for custom code to be loaded into the Aggregator specifically for UDAs typically deployed in a kxi-db chart.<br>More information can be found [here](https://code.kx.com/insights/1.15/microservices/database/configuration/uda.html#load-uda). |
| `kxi-gw.kxiAgg.customCode.configMap` | `string` | <code>""</code> | If `customCode.configMap` is populated there should be a `configMap` deployed by that name and it will be mounted into the Aggregator. |
| `kxi-gw.kxiAgg.customCode.entry` | `string` | <code>""</code> | The entrypoint should be the name of the file which is executed to load the custom code. |
| `kxi-gw.kxiAgg.envs` | `list` | <code>[<br/>&nbsp;&nbsp;{<br/>&nbsp;&nbsp;&nbsp;&nbsp;"name": "KXI_LOG_FORMAT",<br/>&nbsp;&nbsp;&nbsp;&nbsp;"value": "text"<br/>&nbsp;&nbsp;},<br/>&nbsp;&nbsp;{<br/>&nbsp;&nbsp;&nbsp;&nbsp;"name": "KXI_LOG_LEVELS",<br/>&nbsp;&nbsp;&nbsp;&nbsp;"value": "default:debug"<br/>&nbsp;&nbsp;}<br/>]</code> | Default common environment variables for the Aggregator.<br>Additional ENVs can be added and these overridden in custom values files.<br>If overriding `envs`, ensure you include all the default values. |
| `kxi-gw.kxiAgg.image` | `object` | <code>{}</code> | This sets overriding container image information.<br>Use if you wish to target specific versions of the Agg.<br>More information can be found [here](https://kubernetes.io/docs/concepts/containers/images/). |
| `kxi-gw.kxiAgg.image.tag` | `string` | <code>""</code> | Image tag. |
| `kxi-gw.kxiAgg.nodeSelector` | `object` | <code>{}</code> | Allows adding node selector constraints to the Aggregator.<br>This constrains the pods to run only on nodes that match the specified labels.<br>Dictionary of key-value pairs.<br>Refer to [NodeSelector](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector). |
| `kxi-gw.kxiAgg.podAnnotations` | `object` | <code>{}</code> | This is for setting Kubernetes Annotations to a Pod.<br>Dictionary of key-value pairs.<br>Refer to [Object Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/). |
| `kxi-gw.kxiAgg.podLabels` | `object` | <code>{}</code> | This is for setting Kubernetes Labels to a Pod.<br>Dictionary of key-value pairs.<br>Refer to [Object Labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/). |
| `kxi-gw.kxiAgg.replicaCount` | `int` | <code>1</code> | This sets the number of replicas for the Aggregator.<br>More information can be found [here](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#replicas-and-scaling). |
| `kxi-gw.kxiAgg.resources` | `object` | <code>{}</code> | Aggregator Kubernetes resources.<br>Refer to [Container Resources](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/). |
| `kxi-gw.kxiAgg.service` | `object` | <code>{}</code> | This is for setting up an Aggregator service.<br>More information can be found [here](https://kubernetes.io/docs/concepts/services-networking/service/). |
| `kxi-gw.kxiAgg.service.annotations` | `object` | <code>{}</code> | This sets the service annotations for the Aggregator.<br>Dictionary of key-value pairs.<br>Refer to [Object Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/). |
| `kxi-gw.kxiAgg.service.port` | `int` | <code>5060</code> | Set exposed Service Port.<br>Refer to [Service Ports](https://kubernetes.io/docs/concepts/services-networking/service/#field-spec-ports). |
| `kxi-gw.kxiAgg.service.type` | `string` | <code>"ClusterIP"</code> | Sets the Service type.<br>Refer to [Service Types](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types). |
| `kxi-gw.kxiAgg.tolerations` | `list` | <code>[]</code> | Allows adding tolerations to the Aggregator.<br>This allows the pods to be scheduled on nodes with matching taints.<br>Refer to [Taint and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/). |
| `kxi-gw.kxiAgg.volumeMounts` | `list` | <code>[]</code> | Allows additional `volumeMounts` to be added to the Aggregator. |
| `kxi-gw.kxiAgg.volumes` | `list` | <code>[]</code> | Allows additional `volumes` to be added to the Aggregator. |
| `kxi-gw.kxiRc.affinity` | `object` | <code>{}</code> | Allows adding affinities to the Resource Coordinator.<br>Refer to [Pod Affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity). |
| `kxi-gw.kxiRc.allowedSbxApis` | `string` | <code>".kxi.sql,.kxi.qsql,.kxi.sql2"</code> | Sets the available free string queries available for the RC.<br> Each has security and performance implications.<br>More information can be found [here](https://code.kx.com/insights/api/kxi-python/query.html#qsql). |
| `kxi-gw.kxiRc.args` | `list` | <code>[]</code> | Can provide any valid `q` runtime argument here.<br>Full details [here](https://code.kx.com/q/basics/cmdline/).<br>**NOTE** the '-p' argument will be overridden by the `KXI_PORT` env variable. |
| `kxi-gw.kxiRc.envs` | `list` | <code>[<br/>&nbsp;&nbsp;{<br/>&nbsp;&nbsp;&nbsp;&nbsp;"name": "KXI_LOG_FORMAT",<br/>&nbsp;&nbsp;&nbsp;&nbsp;"value": "text"<br/>&nbsp;&nbsp;},<br/>&nbsp;&nbsp;{<br/>&nbsp;&nbsp;&nbsp;&nbsp;"name": "KXI_LOG_LEVELS",<br/>&nbsp;&nbsp;&nbsp;&nbsp;"value": "default:debug"<br/>&nbsp;&nbsp;}<br/>]</code> | Default common environment variables for the Resource Coordinator.<br>Additional ENVs can be added and these overridden in custom values files.<br>If overriding `envs`, ensure you include all the default values. |
| `kxi-gw.kxiRc.image` | `object` | <code>{}</code> | This sets overriding container image information.<br>Use if you wish to target specific versions of the RC.<br>More information can be found [here](https://kubernetes.io/docs/concepts/containers/images/). |
| `kxi-gw.kxiRc.image.tag` | `string` | <code>""</code> | Image tag. |
| `kxi-gw.kxiRc.nodeSelector` | `object` | <code>{}</code> | Allows adding node selector constraints to a Pod.<br>This constrains the pods to run only on nodes that match the specified labels.<br>Dictionary of key-value pairs.<br>Refer to [NodeSelector](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector). |
| `kxi-gw.kxiRc.podAnnotations` | `object` | <code>{}</code> | Custom annotations to be applied to Pod resources.<br>Dictionary of key-value pairs.<br>Refer to [Object Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/). |
| `kxi-gw.kxiRc.podLabels` | `object` | <code>{}</code> | Custom labels to be applied to Pod resources.<br>Dictionary of key-value pairs.<br>Refer to [Object Labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/). |
| `kxi-gw.kxiRc.resources` | `object` | <code>{}</code> | Resource Coordinator Kubernetes resources.<br>Refer to [Container Resources](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/). |
| `kxi-gw.kxiRc.service` | `object` | <code>{}</code> | Provisions the Kubernetes Service required to expose the workloads.<br>More information can be found [here](https://kubernetes.io/docs/concepts/services-networking/service/). |
| `kxi-gw.kxiRc.service.port` | `int` | <code>5040</code> | Set exposed Service Port.<br>Refer to [Service Ports](https://kubernetes.io/docs/concepts/services-networking/service/#field-spec-ports). |
| `kxi-gw.kxiRc.service.type` | `string` | <code>"ClusterIP"</code> | This sets the Service type.<br>Setting the type field to `LoadBalancer` provisions a load balancer for your Service.<br>The actual creation of the load balancer happens asynchronously, and information about the provisioned balancer is published in the Service's `.status.loadBalancer`.<br>More information can be found [here](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types). |
| `kxi-gw.kxiRc.tolerations` | `list` | <code>[]</code> | This is for setting Kubernetes Tolerations to a Pod.<br>This allows the pods to be scheduled on nodes with matching taints.<br>Refer to [Taint and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/). |
| `kxi-gw.kxiRc.volumeMounts` | `list` | <code>[]</code> | Allows additional `volumeMounts` to be added to the Resource Coordinator.<br>Refer to [Volumes](https://kubernetes.io/docs/concepts/storage/volumes/). |
| `kxi-gw.kxiRc.volumes` | `list` | <code>[]</code> | Allows additional `volumes` to be added to the Resource Coordinator.<br>Refer to [Volumes](https://kubernetes.io/docs/concepts/storage/volumes/). |
| `kxi-gw.kxiSg.affinity` | `object` | <code>{}</code> | Allows adding affinities to the Service Gateway.<br>Refer to [Pod Affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity). |
| `kxi-gw.kxiSg.customIpcAuth` | `object` | <code>{}</code> | Custom IPC Authorization configuration.<br>Configure the `customIpcAuth` section to enable custom authentication for an IPC connection to the Service Gateway.<br>More information can be found [here](https://code.kx.com/insights/microservices/database/configuration/advanced/custom-auth-ipc.html). |
| `kxi-gw.kxiSg.customIpcAuth.enabled` | `bool` | <code>false</code> | Enable/disable custom IPC authorization sidecar. |
| `kxi-gw.kxiSg.customIpcAuth.sidecar.authApi` | `string` | <code>"authorize"</code> | Custom authorization function name (defaults to `"authorize"`). |
| `kxi-gw.kxiSg.customIpcAuth.sidecar.envs` | `list` | <code>[<br/>&nbsp;&nbsp;{<br/>&nbsp;&nbsp;&nbsp;&nbsp;"name": "QLIC",<br/>&nbsp;&nbsp;&nbsp;&nbsp;"value": "/opt/kx/lic"<br/>&nbsp;&nbsp;}<br/>]</code> | Additional environment variables for the authorization sidecar. |
| `kxi-gw.kxiSg.customIpcAuth.sidecar.image` | `object` | <code>{}</code> | Container image for the custom authorization sidecar. |
| `kxi-gw.kxiSg.customIpcAuth.sidecar.image.name` | `string` | <code>""</code> | The name of the custom authentication sidecar image. |
| `kxi-gw.kxiSg.customIpcAuth.sidecar.image.pullPolicy` | `string` | <code>"IfNotPresent"</code> | Image pull policy.<br>Refer to [Image Pull Policy](https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy). |
| `kxi-gw.kxiSg.customIpcAuth.sidecar.image.repository` | `string` | <code>"portal.dl.kx.com/"</code> | Where the custom authentication sidecar image is located. |
| `kxi-gw.kxiSg.customIpcAuth.sidecar.image.tag` | `string` | <code>""</code> | The tag of the custom authentication sidecar image. |
| `kxi-gw.kxiSg.customIpcAuth.sidecar.port` | `int` | <code>5000</code> | Port for the authorization sidecar IPC connection. |
| `kxi-gw.kxiSg.customIpcAuth.sidecar.resources` | `object` | <code>{}</code> | Resource limits and requests for the authorization sidecar.<br>Refer to [Container Resources](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/). |
| `kxi-gw.kxiSg.customIpcAuth.sidecar.useTls` | `bool` | <code>false</code> | Enable TLS for IPC connection to authorization sidecar. |
| `kxi-gw.kxiSg.customIpcAuth.sidecar.volumeMounts` | `list` | <code>[]</code> | Additional volume mounts for the authorization sidecar.<br>Refer to [Volumes](https://kubernetes.io/docs/concepts/storage/volumes/). |
| `kxi-gw.kxiSg.customIpcAuth.sidecar.volumes` | `list` | <code>[]</code> | Additional volumes for the authorization sidecar.<br>Refer to [Volumes](https://kubernetes.io/docs/concepts/storage/volumes/). |
| `kxi-gw.kxiSg.envs` | `list` | <code>[<br/>&nbsp;&nbsp;{<br/>&nbsp;&nbsp;&nbsp;&nbsp;"name": "KXI_LOG_FORMAT",<br/>&nbsp;&nbsp;&nbsp;&nbsp;"value": "text"<br/>&nbsp;&nbsp;},<br/>&nbsp;&nbsp;{<br/>&nbsp;&nbsp;&nbsp;&nbsp;"name": "KXI_LOG_LEVELS",<br/>&nbsp;&nbsp;&nbsp;&nbsp;"value": "default:debug"<br/>&nbsp;&nbsp;},<br/>&nbsp;&nbsp;{<br/>&nbsp;&nbsp;&nbsp;&nbsp;"name": "KXI_SG_CORS_ENABLED",<br/>&nbsp;&nbsp;&nbsp;&nbsp;"value": "false"<br/>&nbsp;&nbsp;},<br/>&nbsp;&nbsp;{<br/>&nbsp;&nbsp;&nbsp;&nbsp;"name": "KXI_SG_CORS_ORIGINS",<br/>&nbsp;&nbsp;&nbsp;&nbsp;"value": ""<br/>&nbsp;&nbsp;}<br/>]</code> | Default common environment variables for the Service Gateway.<br>Additional ENVs can be added and these overridden in custom values files.<br>If overriding `envs`, ensure you include all the default values. |
| `kxi-gw.kxiSg.envs[2]` | `object` | <code>{<br/>&nbsp;&nbsp;"name": "KXI_SG_CORS_ENABLED",<br/>&nbsp;&nbsp;"value": "false"<br/>}</code> | Enables CORS headers to allow external domains to access the Service Gateway |
| `kxi-gw.kxiSg.envs[3]` | `object` | <code>{<br/>&nbsp;&nbsp;"name": "KXI_SG_CORS_ORIGINS",<br/>&nbsp;&nbsp;"value": ""<br/>}</code> | Comma separated list of the full FQDN remote domains which are allowed to access the Service Gateway |
| `kxi-gw.kxiSg.envs[4]` | `object` | <code>{<br/>&nbsp;&nbsp;"name": "KXI_SG_USE_SSL",<br/>&nbsp;&nbsp;"value": "0"<br/>}</code> | When `customIpcAuth.enabled` is set to `true`, this defines if the `service.ports.qipcext` port should use SSL. |
| `kxi-gw.kxiSg.image` | `object` | <code>{}</code> | This sets overriding container image information.<br>Use if you wish to target specific versions of the Service Gateway.<br>More information can be found [here](https://kubernetes.io/docs/concepts/containers/images/). |
| `kxi-gw.kxiSg.image.tag` | `string` | <code>""</code> | Image tag. |
| `kxi-gw.kxiSg.nodeSelector` | `object` | <code>{}</code> | Allows adding node selector constraints to the Service Gateway.<br>This constrains the pods to run only on nodes that match the specified labels.<br>Dictionary of key-value pairs.<br>Refer to [NodeSelector](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector). |
| `kxi-gw.kxiSg.podAnnotations` | `object` | <code>{}</code> | This is for setting Kubernetes Annotations to a Pod.<br>Dictionary of key-value pairs.<br>Refer to [Object Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/). |
| `kxi-gw.kxiSg.podLabels` | `object` | <code>{}</code> | This is for setting Kubernetes Labels to a Pod.<br>Dictionary of key-value pairs.<br>Refer to [Object Labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/). |
| `kxi-gw.kxiSg.replicaCount` | `int` | <code>1</code> | This sets the number of replicas for the Service Gateway.<br>More information can be found [here](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#replicas-and-scaling). |
| `kxi-gw.kxiSg.resources` | `object` | <code>{}</code> | Service Gateway Kubernetes resources.<br>Refer to [Container Resources](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/). |
| `kxi-gw.kxiSg.service.annotations` | `object` | <code>{}</code> | This sets the service annotations for the Service Gateway.<br>Refer to [Object Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/). |
| `kxi-gw.kxiSg.service.ports` | `object` | <code>{<br/>&nbsp;&nbsp;"http": 8080,<br/>&nbsp;&nbsp;"qipc": 5050,<br/>&nbsp;&nbsp;"qipcext": 5051<br/>}</code> | Set list of exposed service ports. |
| `kxi-gw.kxiSg.service.ports.http` | `int` | <code>8080</code> | REST/HTTP port |
| `kxi-gw.kxiSg.service.ports.qipc` | `int` | <code>5050</code> | TCP/qIPC port |
| `kxi-gw.kxiSg.service.ports.qipcext` | `int` | <code>5051</code> | When `customIpcAuth.enabled` is set to `true`, this port is used for the external qIPC connection to the Service Gateway.<br>More information can be found [here](https://code.kx.com/insights/microservices/gateway/configuration/custom-ipc-auth.html). |
| `kxi-gw.kxiSg.service.type` | `string` | <code>"ClusterIP"</code> | Sets the Service type.<br>Refer to [Service Types](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types). |
| `kxi-gw.kxiSg.tolerations` | `list` | <code>[]</code> | Allows adding tolerations to the Service Gateway.<br>This allows the pods to be scheduled on nodes with matching taints.<br>Refer to [Taint and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/). |
| `kxi-gw.kxiSg.volumeMounts` | `list` | <code>[]</code> | Allows additional `volumeMounts` to be added to the Service Gateway. |
| `kxi-gw.kxiSg.volumes` | `list` | <code>[]</code> | Allows additional `volumes` to be added to the Service Gateway. |
| `kxi-gw.kxiSidecar` | `object` | <code>{}</code> | Default Sidecar configuration for Insights Gateway chart components. |
| `kxi-gw.kxiSidecar.image` | `object` | <code>{}</code> | This sets overriding container image information.<br>Use if you wish to target specific versions of the kxiSidecar.<br>More information can be found [here](https://kubernetes.io/docs/concepts/containers/images/). |
| `kxi-gw.kxiSidecar.image.tag` | `string` | <code>"1.19.2"</code> | Image tag. |
| `kxi-gw.nameOverride` | `string` | <code>""</code> | This sets the name of the InsightsGW deployment.<br>Overriding Chart name.<br>Used when generating resource names. |
| `kxi-gw.podSecurityContext` | `object` | <code>{}</code> | Default Pod Security Context for Insights Gateway chart components.<br>Refer to [Pod Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod). |
| `kxi-gw.securityContext` | `object` | <code>{}</code> | Default security context for Insights Gateway chart components.<br>Refer to [Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container). |

#### kxi-sp

Configuration for the `kxi-sp` Subchart.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| `kxi-sp.affinity` | `object` | <code>{}</code> | This is for setting Kubernetes Affinity to a Pod.<br>Refer to [Pod Affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity). |
| `kxi-sp.args` | `list` | <code>[<br/>&nbsp;&nbsp;"-kube",<br/>&nbsp;&nbsp;"-g",<br/>&nbsp;&nbsp;"1",<br/>&nbsp;&nbsp;"-p",<br/>&nbsp;&nbsp;"5000"<br/>]</code> | Can provide any valid `q` runtime argument here.<br>Full details [here](https://code.kx.com/q/basics/cmdline/).<br>**NOTE** the `-p` argument will be overridden by the `KXI_PORT` env variable. |
| `kxi-sp.env` | `list` | <code>[]</code> | Setup Environment variables here for the SP container. |
| `kxi-sp.fullnameOverride` | `string` | <code>""</code> | Override the default fully qualified app name.<br>By default resources are named using `<.Release.Name>-<.Chart.Name>`.<br>Used when generating resource names. |
| `kxi-sp.image` | `object` | <code>{}</code> | Default image repository and pull settings for SP chart components.<br>Refer to [Images](https://kubernetes.io/docs/concepts/containers/images/). |
| `kxi-sp.image.component` | `string` | <code>".Chart.Name"</code> | Image component. |
| `kxi-sp.image.pullPolicy` | `string` | <code>"IfNotPresent"</code> | Image pull policy.<br>Refer to [Image Pull Policy](https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy). |
| `kxi-sp.image.repository` | `string` | <code>"portal.dl.kx.com/"</code> | Image repository. |
| `kxi-sp.image.tag` | `string` | <code>".Chart.AppVersion"</code> | Image tag. |
| `kxi-sp.imagePullSecrets` | `list` | <code>[]</code> | Image pull secrets to be applied to all pods within the chart.<br>For pulling an image from a private repository.<br>Refer to [Image Pull Secrets](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/). |
| `kxi-sp.kxLicenseName` | `string` | <code>"kc.lic"</code> | You must set your license name.<br>Available types are:  - `"kc.lic"`  - `"k4.lic"`  - `"kx.lic"` |
| `kxi-sp.kxiSidecar` | `object` | <code>{}</code> | Default Sidecar configuration for SP components |
| `kxi-sp.kxiSidecar.image` | `object` | <code>{}</code> | This sets overriding container image information.<br>Use if you wish to target specific versions of the kxiSidecar.<br>More information can be found [here](https://kubernetes.io/docs/concepts/containers/images/). |
| `kxi-sp.kxiSidecar.image.tag` | `string` | <code>"1.19.2"</code> | Image tag. |
| `kxi-sp.livenessProbe` | `object` | <code>{}</code> | Configure Liveness Probe for chart.<br>Refer to [Configure Probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/). |
| `kxi-sp.livenessProbe.httpGet` | `object` | <code>{}</code> | Defines a probe of type `"httpGet"`. |
| `kxi-sp.livenessProbe.httpGet.path` | `string` | <code>"/"</code> | Path to access on the HTTP server. |
| `kxi-sp.livenessProbe.httpGet.port` | `int` | <code>5000</code> | Name or number of the port to access on the container. |
| `kxi-sp.nameOverride` | `string` | <code>""</code> | Override Chart name.<br>Used when generating resource names. |
| `kxi-sp.nodeSelector` | `object` | <code>{}</code> | Allows adding node selector constraints to a Pod.<br>This constrains the pods to run only on nodes that match the specified labels.<br>Dictionary of key-value pairs.<br>Refer to [NodeSelector](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector). |
| `kxi-sp.persistence.enabled` | `bool` | <code>false</code> | Enable persistence within release. |
| `kxi-sp.podAnnotations` | `object` | <code>{}</code> | Custom annotations to be applied to Pod resources.<br>Dictionary of key-value pairs.<br>Refer to [Object Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/). |
| `kxi-sp.podLabels` | `object` | <code>{}</code> | Custom labels to be applied to Pod resources.<br>Dictionary of key-value pairs.<br>Refer to [Object Labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/). |
| `kxi-sp.podSecurityContext` | `object` | <code>{}</code> | Pod Level Security Context - Configure the Pod Security Context.<br>Refer to [Pod Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod). |
| `kxi-sp.readinessProbe` | `object` | <code>{}</code> | Configure Readiness Probe for chart.<br>Refer to [Configure Probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/). |
| `kxi-sp.readinessProbe.httpGet` | `object` | <code>{}</code> | Defines a probe of type `"httpGet"`. |
| `kxi-sp.readinessProbe.httpGet.path` | `string` | <code>"/"</code> | Path to access on the HTTP server. |
| `kxi-sp.readinessProbe.httpGet.port` | `int` | <code>5000</code> | Name or number of the port to access on the container. |
| `kxi-sp.replicaCount` | `int` | <code>1</code> | This sets the `replicaSet` count.<br>More information can be found [here](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/). |
| `kxi-sp.resources` | `object` | <code>{}</code> | Resource Coordinator Kubernetes resources.<br>Refer to [Container Resources](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/). |
| `kxi-sp.securityContext` | `object` | <code>{}</code> | Container Level Security Context - Configure the Container Security Context.<br>Refer to [Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container). |
| `kxi-sp.service` | `object` | <code>{}</code> | Provisions the Kubernetes Service required to expose the workloads.<br>This is for setting up a service more information can be found [here](https://kubernetes.io/docs/concepts/services-networking/service/). |
| `kxi-sp.service.port` | `int` | <code>5000</code> | Set exposed Service Port.<br>Refer to [Service Ports](https://kubernetes.io/docs/concepts/services-networking/service/#field-spec-ports). |
| `kxi-sp.service.type` | `string` | <code>"ClusterIP"</code> | This sets the Service type.<br>Setting the type field to `LoadBalancer` provisions a load balancer for your Service.<br>The actual creation of the load balancer happens asynchronously, and information about the provisioned balancer is published in the Service's `.status.loadBalancer`.<br>More information can be found [here](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types). |
| `kxi-sp.serviceAccount` | `object` | <code>{}</code> | Configure `ServiceAccount` to be used within chart.<br>Refer to [Service Accounts](https://kubernetes.io/docs/concepts/security/service-accounts/). |
| `kxi-sp.serviceAccount.annotations` | `object` | <code>{}</code> | Custom annotations to add to the Service Account.<br>Dictionary of key-value pairs.<br>Refer to [Object Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/). |
| `kxi-sp.serviceAccount.autoMount` | `bool` | <code>true</code> | Automatically mount a Service Account's API credentials. |
| `kxi-sp.serviceAccount.create` | `bool` | <code>true</code> | Specifies whether a Service Account should be created. |
| `kxi-sp.serviceAccount.name` | `string` | <code>""</code> | The name of the Service Account to use.<br>If not set and create is `true`, a name is generated using the fullname template. |
| `kxi-sp.tolerations` | `list` | <code>[]</code> | This is for setting Kubernetes Tolerations to a Pod This allows the pods to be scheduled on nodes with matching taints.<br>Refer to [Taint and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/). |
| `kxi-sp.volumeMounts` | `list` | <code>[]</code> | Additional volumeMounts on the output Deployment definition. |
| `kxi-sp.volumes` | `list` | <code>[]</code> | Additional volumes on the output Deployment definition. |
