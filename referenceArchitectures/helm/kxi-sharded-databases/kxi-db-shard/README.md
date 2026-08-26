# kxi-db-shard

A Helm chart for the sharded databases

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../../../../kxCharts/kxi-db | kxi-db | 1.19.3 |
| file://../../../../kxCharts/kxi-rt | kxi-rt | 1.19.2 |

## Configuration Options

### Subchart configuration

Configuration for subcharts of `kxi-db-shard`.

#### kxi-db

Configuration for the `kxi-db` Subchart.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| `kxi-db.assembly.filename` | `string` | <code>"assembly.yaml"</code> | This defines the assembly file to be loaded into the InsightsDB.<br>It should be on the base directory of the chart folder under `kxi-db`.<br>More information can be found [here](https://code.kx.com/insights/microservices/database/configuration/assembly/database.html). |
| `kxi-db.db.hdbt1.size` | `string` | <code>""</code> | Size of the HDB Tier 1 persistent storage. |
| `kxi-db.db.hdbt1.storageClassName` | `string` | <code>""</code> | Defines the storageClassNames for all the persistent data storage in the InsightsDB.<br>This should map to Kubernetes storageClassNames with accessMode of `RWM`.<br>More information can be found [here](https://kubernetes.io/docs/concepts/storage/storage-classes/). |
| `kxi-db.db.idb.size` | `string` | <code>""</code> | Size of the Intraday persistent storage. |
| `kxi-db.db.idb.storageClassName` | `string` | <code>""</code> | Defines the storageClassNames for all the persistent data storage in the InsightsDB.<br>This should map to Kubernetes storageClassNames with accessMode of `RWM`.<br>More information can be found [here](https://kubernetes.io/docs/concepts/storage/storage-classes/). |
| `kxi-db.fullnameOverride` | `string` | <code>""</code> | This sets the full name of the InsightsDB deployment.<br>Override the default fully qualified app name.<br>By default resources are named using `<.Release.Name>-<.Chart.Name>`.<br>Used when generating resource names. |
| `kxi-db.image` | `object` | <code>{}</code> | Default image repository and pull settings for InsightsDB chart components.<br>Refer to [Images](https://kubernetes.io/docs/concepts/containers/images/). |
| `kxi-db.image.pullPolicy` | `string` | <code>"IfNotPresent"</code> | Image pull policy.<br>Refer to [Image Pull Policy](https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy). |
| `kxi-db.image.repository` | `string` | <code>"portal.dl.kx.com/"</code> | Image repository. |
| `kxi-db.imagePullSecrets` | `list` | <code>[]</code> | Image pull secrets to be applied to all pods within the chart.<br>For pulling an image from a private repository.<br>More information can be found [here](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/). |
| `kxi-db.imagePullSecrets[0].name` | `string` | <code>"kx-pull-secret"</code> |  |
| `kxi-db.kxLicenseName` | `string` | <code>"kc.lic"</code> | You must set your license name.<br>Default is `"kc.lic"`.<br>Available types are:  - `"kc.lic"`  - `"k4.lic"`  - `"kx.lic"` |
| `kxi-db.kxiDa.affinity` | `object` | <code>{}</code> | This is for setting Kubernetes Affinity to a Pod.<br>Refer to [Pod Affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity). |
| `kxi-db.kxiDa.allowedSbxApis` | `string` | <code>".kxi.sql,.kxi.qsql,.kxi.sql2"</code> | Sets the available free string queries available for the DA.<br> Each has security and performance implications.<br>More information can be found [here](https://code.kx.com/insights/api/kxi-python/query.html#qsql). |
| `kxi-db.kxiDa.args` | `list` | <code>[]</code> | Can provide any valid `q` runtime argument here.<br>Full details [here](https://code.kx.com/q/basics/cmdline/).<br>**NOTE** the `-p` argument will be overridden by the `KXI_PORT` env variable. |
| `kxi-db.kxiDa.customCodeEntry` | `string` | <code>"udas.q"</code> | Entrypoint for custom code written under `customcode`.<br>Create your custom code and UDAs under here and it will be loaded into the DA under `/opt/kx/packages/{customCodeEntry}.q`.<br>More information can be found [here](https://code.kx.com/insights/1.15/microservices/database/configuration/uda.html#load-uda). |
| `kxi-db.kxiDa.envs` | `list` | <code>[<br/>&nbsp;&nbsp;{<br/>&nbsp;&nbsp;&nbsp;&nbsp;"name": "KXI_LOG_FORMAT",<br/>&nbsp;&nbsp;&nbsp;&nbsp;"value": "text"<br/>&nbsp;&nbsp;},<br/>&nbsp;&nbsp;{<br/>&nbsp;&nbsp;&nbsp;&nbsp;"name": "KXI_LOG_LEVELS",<br/>&nbsp;&nbsp;&nbsp;&nbsp;"value": "default:debug"<br/>&nbsp;&nbsp;}<br/>]</code> | Default common environment variables for the DA.<br>Additional ENVs can be added and these overridden in custom values files.<br>If overriding `envs`, ensure you include all the default values. |
| `kxi-db.kxiDa.image` | `object` | <code>{}</code> | This sets overriding container image information.<br>Use if you wish to target specific versions of the DA.<br>More information can be found [here](https://kubernetes.io/docs/concepts/containers/images/). |
| `kxi-db.kxiDa.image.tag` | `string` | <code>""</code> | Image tag. |
| `kxi-db.kxiDa.nodeSelector` | `object` | <code>{}</code> | Allows adding node selector constraints to a Pod.<br>This constrains the pods to run only on nodes that match the specified labels.<br>Dictionary of key-value pairs.<br>Refer to [NodeSelector](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector). |
| `kxi-db.kxiDa.podAnnotations` | `object` | <code>{}</code> | This is for setting Kubernetes Annotations to a Pod.<br>Dictionary of key-value pairs.<br>Refer to [Object Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/). |
| `kxi-db.kxiDa.podLabels` | `object` | <code>{}</code> | This is for setting Kubernetes Labels to a Pod.<br>Dictionary of key-value pairs.<br>Refer to [Object Labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/). |
| `kxi-db.kxiDa.podManagementPolicy` | `string` | <code>"Parallel"</code> | Define how pods are created/deleted.<br>`OrderedReady`, sequential; `Parallel`, all at once.<br>Refer to [Pod Management](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#pod-management-policies). |
| `kxi-db.kxiDa.rcAddr` | `string` | <code>""</code> | Defines the name and port of the RC to allow the data to be accessed via queries.<br>This must be set to the appropriate full FQDN RC service and port.<br>This should include RELEASENAME that will be used for deployment to have final value as `RELEASENAME-kxi-gw-rc:5040` |
| `kxi-db.kxiDa.replicaCount` | `int` | <code>1</code> | This sets the number of replicas for the DA.<br>More information can be found [here](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#replicas-and-scaling). |
| `kxi-db.kxiDa.resources` | `object` | <code>{}</code> | DA Kubernetes resources.<br>Refer to [Container Resources](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/). |
| `kxi-db.kxiDa.rtLogs` | `object` | <code>{<br/>&nbsp;&nbsp;"size": "2Gi"<br/>}</code> | This defines how much storage should be assigned for rt logs storage in the DA. |
| `kxi-db.kxiDa.secureEnabled` | `bool` | <code>false</code> | Defines whether InsightsDB is secured to prevent qsql-based string executions.<br>If enabled only API function queries will be allowed on the InsightsDB. |
| `kxi-db.kxiDa.service` | `object` | <code>{}</code> | This is for setting up a service and the port in use by the DA.<br>More information can be found [here](https://kubernetes.io/docs/concepts/services-networking/service/). |
| `kxi-db.kxiDa.service.annotations` | `object` | <code>{}</code> | This sets the service annotations for the DAP.<br>Dictionary of key-value pairs.<br>Refer to [Object Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/). |
| `kxi-db.kxiDa.service.port` | `int` | <code>5040</code> | Set exposed Service Port.<br>Refer to [Service Ports](https://kubernetes.io/docs/concepts/services-networking/service/#field-spec-ports). |
| `kxi-db.kxiDa.serviceClassConfig` | `string` | <code>"dap"</code> | Links the DA to the appropriate service class configuration in your assembly under `elements.dap.instances`.<br>More information can be found [here](https://code.kx.com/draft/insights/enterprise/database/configuration/package/storage.html#environment-variables). |
| `kxi-db.kxiDa.tolerations` | `list` | <code>[]</code> | This is for setting Kubernetes Tolerations to a Pod.<br>This allows the pods to be scheduled on nodes with matching taints.<br>Refer to [Taint and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/). |
| `kxi-db.kxiDa.updateStrategy` | `object` | <code>{}</code> | Define how pod updates are applied.<br>`RollingUpdate`, replace gradually; `OnDelete`, replace only on delete.<br>More information can be found [here](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#update-strategies). |
| `kxi-db.kxiDa.volumeMounts` | `list` | <code>[]</code> | Allows additional `volumeMounts` to be added to the DA Refer to [Volumes](https://kubernetes.io/docs/concepts/storage/volumes/). |
| `kxi-db.kxiDa.volumes` | `list` | <code>[]</code> | Allows additional `volumes` to be added to the DAP.<br>Refer to [Volumes](https://kubernetes.io/docs/concepts/storage/volumes/). |
| `kxi-db.kxiSidecar.image` | `object` | <code>{}</code> | This sets overriding container image information.<br>Use if you wish to target specific versions of the kxiSidecar.<br>More information can be found [here](https://kubernetes.io/docs/concepts/containers/images/). |
| `kxi-db.kxiSidecar.image.tag` | `string` | <code>"1.19.2"</code> | Image tag. |
| `kxi-db.kxiSm.affinity` | `object` | <code>{}</code> | This is for setting Kubernetes Affinity to a Pod.<br>Refer to [Pod Affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity). |
| `kxi-db.kxiSm.args` | `list` | <code>[]</code> | Can provide any valid `q` runtime argument here.<br>Full details [here](https://code.kx.com/q/basics/cmdline/).<br>**NOTE** the `-p` argument will be overridden by the `KXI_PORT` env variable. |
| `kxi-db.kxiSm.envs` | `list` | <code>[<br/>&nbsp;&nbsp;{<br/>&nbsp;&nbsp;&nbsp;&nbsp;"name": "KXI_LOG_FORMAT",<br/>&nbsp;&nbsp;&nbsp;&nbsp;"value": "text"<br/>&nbsp;&nbsp;},<br/>&nbsp;&nbsp;{<br/>&nbsp;&nbsp;&nbsp;&nbsp;"name": "KXI_LOG_LEVELS",<br/>&nbsp;&nbsp;&nbsp;&nbsp;"value": "default:debug"<br/>&nbsp;&nbsp;}<br/>]</code> | Default common environment variables for the SM.<br>Additional ENVs can be added and these overridden in custom values files.<br>If overriding `envs`, ensure you include all the default values. |
| `kxi-db.kxiSm.image` | `object` | <code>{}</code> | This sets overriding container image information.<br>Use if you wish to target specific versions of the SM.<br>More information can be found [here](https://kubernetes.io/docs/concepts/containers/images/). |
| `kxi-db.kxiSm.image.tag` | `string` | <code>""</code> | Image tag. |
| `kxi-db.kxiSm.nodeSelector` | `object` | <code>{}</code> | Allows adding node selector constraints to a Pod.<br>This constrains the pods to run only on nodes that match the specified labels.<br>Dictionary of key-value pairs.<br>Refer to [NodeSelector](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector). |
| `kxi-db.kxiSm.podAnnotations` | `object` | <code>{}</code> | This is for setting Kubernetes Annotations to a Pod.<br>Dictionary of key-value pairs.<br>Refer to [Object Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/). |
| `kxi-db.kxiSm.podLabels` | `object` | <code>{}</code> | This is for setting Kubernetes Labels to a Pod.<br>Dictionary of key-value pairs.<br>Refer to [Object Labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/). |
| `kxi-db.kxiSm.podManagementPolicy` | `string` | <code>"Parallel"</code> | Define how pods are created/deleted.<br>`OrderedReady`, sequential; `Parallel`, all at once.<br>Refer to [Pod Management](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#pod-management-policies). |
| `kxi-db.kxiSm.resources` | `object` | <code>{}</code> | Storage Manager Kubernetes resources.<br>Refer to [Container Resources](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/). |
| `kxi-db.kxiSm.rtLogs` | `object` | <code>{<br/>&nbsp;&nbsp;"size": "2Gi"<br/>}</code> | This defines how much storage should be assigned for rt logs storage in the SM. |
| `kxi-db.kxiSm.service` | `object` | <code>{}</code> | This is for setting up a service and the port in use by the SM.<br>More information can be found [here](https://kubernetes.io/docs/concepts/services-networking/service/). |
| `kxi-db.kxiSm.service.port` | `int` | <code>5040</code> | Set exposed Service Port.<br>Refer to [Service Ports](https://kubernetes.io/docs/concepts/services-networking/service/#field-spec-ports). |
| `kxi-db.kxiSm.tolerations` | `list` | <code>[]</code> | This is for setting Kubernetes Tolerations to a Pod.<br>This allows the pods to be scheduled on nodes with matching taints.<br>Refer to [Taint and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/). |
| `kxi-db.kxiSm.updateStrategy` | `object` | <code>{}</code> | Define how pod updates are applied.<br>`RollingUpdate`, replace gradually; `OnDelete`, replace only on delete.<br>More information can be found [here](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#update-strategies). |
| `kxi-db.kxiSm.volumeMounts` | `list` | <code>[]</code> | Allows additional `volumeMounts` to be added to the SM.<br>Refer to [Volumes](https://kubernetes.io/docs/concepts/storage/volumes/). |
| `kxi-db.kxiSm.volumes` | `list` | <code>[]</code> | Allows additional `volumes` to be added to the SM.<br>Refer to [Volumes](https://kubernetes.io/docs/concepts/storage/volumes/). |
| `kxi-db.lateData` | `bool` | <code>false</code> | Defines whether the InsightsDB has `lateData` enabled.<br>More info on `lateData` [here](https://code.kx.com/insights/microservices/database/query/late-data.html#configuring-late-data). |
| `kxi-db.metrics.enabled` | `bool` | <code>true</code> | Enable metric generation. |
| `kxi-db.metrics.handler` | `object` | <code>{}</code> | Enable metric capture for each of the `.z.*` kdb handlers, .e.g { pg: true }.<br>Refer to [dotz](https://code.kx.com/q/ref/dotz/). |
| `kxi-db.nameOverride` | `string` | <code>""</code> | This sets the name of the InsightsDB deployment.<br>Overriding Chart name.<br>Used when generating resource names. |
| `kxi-db.podSecurityContext` | `object` | <code>{}</code> | Default Pod Security Context for InsightsDB chart components.<br>Refer to [Pod Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod). |
| `kxi-db.securityContext` | `object` | <code>{}</code> | Default security context for InsightsDB chart components.<br>Refer to [Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container). |
| `kxi-db.sidecar.connPortList` | `list` | <code>[<br/>&nbsp;&nbsp;5080,<br/>&nbsp;&nbsp;5081,<br/>&nbsp;&nbsp;5082,<br/>&nbsp;&nbsp;5083<br/>]</code> | List of target ports. |
| `kxi-db.sidecar.enabled` | `bool` | <code>true</code> | Enabled Sidecar metric scraping. |
| `kxi-db.sidecar.frequencySecs` | `int` | <code>10</code> | Frequency of scrapes from target container ports. |
| `kxi-db.stream` | `object` | <code>{<br/>&nbsp;&nbsp;"name": "",<br/>&nbsp;&nbsp;"prefix": "rt-"<br/>}</code> | Defines the RT stream name associated with the deployed InsightsDB instance.<br>With prefix must match the deployed name of the RT stream minus replica number.<br>Associated RT Stream pods 'rt-stream-<REPLICA-NO>' |

#### kxi-rt

Configuration for the `kxi-rt` Subchart.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| `kxi-rt.affinity` | `object` | <code>{}</code> | This is for adding affinities to the Reliable Transport.<br>Refer to [Pod Affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity). |
| `kxi-rt.args` | `list` | <code>[<br/>&nbsp;&nbsp;"-time",<br/>&nbsp;&nbsp;"10080",<br/>&nbsp;&nbsp;"-disk",<br/>&nbsp;&nbsp;"90"<br/>]</code> | Can provide any valid `q` runtime argument here.<br>Full details [here](https://code.kx.com/q/basics/cmdline/).<br>Additionally RT archival configuration can be provided here.<br>More information can be found [here](https://code.kx.com/insights/microservices/rt/index.html#archiver). |
| `kxi-rt.envs` | `list` | <code>[<br/>&nbsp;&nbsp;{<br/>&nbsp;&nbsp;&nbsp;&nbsp;"name": "RT_LOGLEVEL_CONSOLE",<br/>&nbsp;&nbsp;&nbsp;&nbsp;"value": "INFO"<br/>&nbsp;&nbsp;},<br/>&nbsp;&nbsp;{<br/>&nbsp;&nbsp;&nbsp;&nbsp;"name": "RT_QURAFT_LOG_LEVEL",<br/>&nbsp;&nbsp;&nbsp;&nbsp;"value": "INFO"<br/>&nbsp;&nbsp;},<br/>&nbsp;&nbsp;{<br/>&nbsp;&nbsp;&nbsp;&nbsp;"name": "RT_LOG_LEADER",<br/>&nbsp;&nbsp;&nbsp;&nbsp;"value": "1"<br/>&nbsp;&nbsp;}<br/>]</code> | Additional ENVs can be added and these overridden in custom values files.<br>For RT configuration options see [here](https://code.kx.com/insights/enterprise/configuration/rt-archival.html#raft-log-retention). |
| `kxi-rt.externalService` | `object` | <code>{}</code> | This is for setting up a additional external services.<br>Setting type to `LoadBalancer` and enabling will expose endpoints external to cluster.<br>More information can be found [here](https://kubernetes.io/docs/concepts/services-networking/service/). |
| `kxi-rt.externalService.annotations` | `object` | <code>{}</code> | This sets the service annotations for the External RT Service.<br>Dictionary of key-value pairs.<br>Refer to [Object Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/). |
| `kxi-rt.externalService.enabled` | `bool` | <code>false</code> | By default external services are disabled |
| `kxi-rt.externalService.loadBalancerIPs` | `object` | <code>{}</code> | This allows you to specify your LoadBalancer's external IP address Should specify one per replica.<br>e.g.<br>`replicaCount: 3`, three IPs should be listed.<br>More information can be found [here](https://kubernetes.io/docs/concepts/services-networking/service/#loadbalancer). |
| `kxi-rt.externalService.type` | `string` | <code>"LoadBalancer"</code> | This sets the Service type.<br>Setting the type field to `LoadBalancer` provisions a load balancer for your Service.<br>The actual creation of the load balancer happens asynchronously, and information about the provisioned balancer is published in the Service's `.status.loadBalancer`.<br>More information can be found [here](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types). |
| `kxi-rt.externalService.useSsl` | `bool` | <code>false</code> | Set to true if you plan to add certification and utilize TCP for data publication. |
| `kxi-rt.image` | `object` | <code>{}</code> | Default image repository and pull settings for Insights RT chart components.<br>Refer to [Images](https://kubernetes.io/docs/concepts/containers/images/). |
| `kxi-rt.image.pullPolicy` | `string` | <code>"IfNotPresent"</code> | Image pull policy.<br>Refer to [Image Pull Policy](https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy). |
| `kxi-rt.image.repository` | `string` | <code>"portal.dl.kx.com/"</code> | Image repository. |
| `kxi-rt.imagePullSecrets` | `list` | <code>[]</code> | Image pull secrets to be applied to all pods within the chart.<br>For pulling an image from a private repository.<br>Refer to [Image Pull Secrets](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/). |
| `kxi-rt.imagePullSecrets[0].name` | `string` | <code>"kx-pull-secret"</code> |  |
| `kxi-rt.kxLicenseName` | `string` | <code>"kc.lic"</code> | You must set your license name.<br>Default is `"kc.lic"`.<br>Available types are:  - `"kc.lic"`  - `"k4.lic"`  - `"kx.lic"` |
| `kxi-rt.kxiSidecar` | `object` | <code>{}</code> | Default Sidecar configuration for Reliable Transport chart components |
| `kxi-rt.kxiSidecar.image` | `object` | <code>{}</code> | This sets overriding container image information.<br>Use if you wish to target specific versions of the kxiSidecar.<br>More information can be found [here](https://kubernetes.io/docs/concepts/containers/images/). |
| `kxi-rt.kxiSidecar.image.tag` | `string` | <code>"1.19.2"</code> | Image tag. |
| `kxi-rt.livenessProbe` | `object` | <code>{}</code> | Configure Liveness Probe for chart.<br>Refer to [Configure Probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/). |
| `kxi-rt.livenessProbe.httpGet` | `object` | <code>{}</code> | Defines a probe of type `"httpGet"`. |
| `kxi-rt.livenessProbe.httpGet.path` | `string` | <code>"/readiness"</code> | Path to access on the HTTP server. |
| `kxi-rt.livenessProbe.httpGet.port` | `int` | <code>6000</code> | Name or number of the port to access on the container. |
| `kxi-rt.livenessProbe.initialDelaySeconds` | `int` | <code>60</code> | Number of seconds after the container has started before liveness probes are initiated. |
| `kxi-rt.livenessProbe.periodSeconds` | `int` | <code>10</code> | How often (in seconds) to perform the probe. |
| `kxi-rt.livenessProbe.successThreshold` | `int` | <code>1</code> | Minimum consecutive successes for the probe to be considered successful after having failed. |
| `kxi-rt.nodeSelector` | `object` | <code>{}</code> | Allows adding node selector constraints to the Reliable Transport.<br>This constrains the pods to run only on nodes that match the specified labels.<br>Dictionary of key-value pairs.<br>Refer to [NodeSelector](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector). |
| `kxi-rt.persistence.accessModes` | `list` | <code>[<br/>&nbsp;&nbsp;"ReadWriteOnce"<br/>]</code> | Persistent Volume Claim Access Modes.<br>More information can be found [here](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes). |
| `kxi-rt.persistence.capacity` | `string` | <code>"2Gi"</code> | Specifies the storage capacity request for the Persistent Volume Claim. |
| `kxi-rt.persistence.storageClass` | `string` | <code>""</code> | Persistent Volume Claim StorageClass.<br>More information can be found [here](https://kubernetes.io/docs/concepts/storage/storage-classes/). |
| `kxi-rt.podAnnotations` | `object` | <code>{}</code> | Custom annotations to be applied to Pod resources.<br>Dictionary of key-value pairs.<br>Refer to [Object Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/). |
| `kxi-rt.podLabels` | `object` | <code>{}</code> | Custom labels to be applied to Pod resources.<br>Dictionary of key-value pairs.<br>Refer to [Object Labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/). |
| `kxi-rt.podManagementPolicy` | `string` | <code>"Parallel"</code> | Define how pods are created/deleted.<br>`OrderedReady`, sequential; `Parallel`, all at once.<br>Refer to [Pod Management](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#pod-management-policies). |
| `kxi-rt.podSecurityContext` | `object` | <code>{}</code> | Default Pod Security Context for Reliable Transport chart components.<br>Refer to [Pod Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod). |
| `kxi-rt.raft` | `object` | <code>{<br/>&nbsp;&nbsp;"chunkSize": 0.25,<br/>&nbsp;&nbsp;"heartbeat": 1000,<br/>&nbsp;&nbsp;"internalTimer": 10,<br/>&nbsp;&nbsp;"logSize": 2<br/>}</code> | Configuration for RT Raft. |
| `kxi-rt.readinessProbe` | `object` | <code>{}</code> | Configure Readiness Probe for chart.<br>Refer to [Configure Probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/). |
| `kxi-rt.readinessProbe.httpGet` | `object` | <code>{}</code> | Defines a probe of type `"httpGet"`. |
| `kxi-rt.readinessProbe.httpGet.path` | `string` | <code>"/readiness"</code> | Path to access on the HTTP server. |
| `kxi-rt.readinessProbe.httpGet.port` | `int` | <code>6000</code> | Name or number of the port to access on the container. |
| `kxi-rt.readinessProbe.periodSeconds` | `int` | <code>2</code> | How often (in seconds) to perform the probe. |
| `kxi-rt.readinessProbe.successThreshold` | `int` | <code>2</code> | Minimum consecutive successes for the probe to be considered successful after having failed. |
| `kxi-rt.readinessProbe.timeoutSeconds` | `int` | <code>5</code> | Number of seconds after which the probe times out. |
| `kxi-rt.replicaCount` | `int` | <code>3</code> | This sets the `replicaSet` count.<br>More information can be found [here](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#replicas-and-scaling). |
| `kxi-rt.resources` | `object` | <code>{}</code> | Reliable Transport Kubernetes resources.<br>Refer to [Container Resources](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/). |
| `kxi-rt.securityContext` | `object` | <code>{}</code> | Default security context for Reliable Transport chart components.<br>Refer to [Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container). |
| `kxi-rt.service` | `object` | <code>{}</code> | Provisions the Kubernetes Service required to expose the workloads.<br>More information can be found [here](https://kubernetes.io/docs/concepts/services-networking/service/). |
| `kxi-rt.service.annotations` | `object` | <code>{}</code> | This sets the service annotations for the Internal RT Service.<br>Dictionary of key-value pairs.<br>Refer to [Object Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/). |
| `kxi-rt.service.type` | `string` | <code>"ClusterIP"</code> | Sets the Service type.<br>Refer to [Service Types](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types). |
| `kxi-rt.serviceAccount` | `object` | <code>{}</code> | Configure `ServiceAccount` to be used within chart.<br>Refer to [Service Accounts](https://kubernetes.io/docs/concepts/security/service-accounts/). |
| `kxi-rt.serviceAccount.annotations` | `object` | <code>{}</code> | Custom annotations to add to the Service Account.<br>Dictionary of key-value pairs.<br>Refer to [Object Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/). |
| `kxi-rt.serviceAccount.autoMount` | `bool` | <code>true</code> | Automatically mount a Service Account's API credentials. |
| `kxi-rt.serviceAccount.create` | `bool` | <code>true</code> | Specifies whether a Service Account should be created. |
| `kxi-rt.serviceAccount.name` | `string` | <code>""</code> | The name of the Service Account to use.<br>If not set and create is `true`, a name is generated using the fullname template. |
| `kxi-rt.tolerations` | `list` | <code>[]</code> | Allows adding tolerations to the Reliable Transport.<br>This allows the pods to be scheduled on nodes with matching taints.<br>Refer to [Taint and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/). |
| `kxi-rt.updateStrategy` | `object` | <code>{}</code> | Define how pod updates are applied.<br>`RollingUpdate`, replace gradually; `OnDelete`, replace only on delete.<br>More information can be found [here](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#update-strategies). |
| `kxi-rt.volumeMounts` | `list` | <code>[]</code> | Additional volumeMounts on the output Deployment definition.<br>Refer to [Volumes](https://kubernetes.io/docs/concepts/storage/volumes/). |
| `kxi-rt.volumes` | `list` | <code>[]</code> | Additional volumes on the output Deployment definition.<br>Refer to [Volumes](https://kubernetes.io/docs/concepts/storage/volumes/). |
