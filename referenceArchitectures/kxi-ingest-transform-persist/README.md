# Ingest, Transform and Persist - SP Based Reference Architecture Chart

## Description
In this reference architecture the key use case solved builds upon the [kxi-ingest-persist](../kxi-ingest-persist) deployment adding a stream processor to deploy dynamic pipelines. It will utilise the kxi-db, kxi-gw, kxi-rt and kxi-sp charts

## Architecture

The implementation consists of:

- A kxi-db chart encompassing the core elements of the InsightsDB which can ingest and persist data
- A kxi-gw chart used to query the data from the kxi-db chart
- A kxi-rt chart as the message bus to log the ingested data and publish to the kxi-db chart
- A kxi-sp chart stream processing system, to taking in the data, transforming and publishing it

![kxi-db chart](../../img/kxi-ingest-transform-persist-arch.png)

## Running on Kubernetes

### Prerequisites

1. `helm` command installed on your local machine
1. A [Distributed storage solution](../README.md#kubernetes-prerequisites) offering RWM access level. (Kubernetes docs for more [here](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes))
1. Authentication details to Kx image repositories
    ```bash
    KX_USER=....
    KX_PASS=....
    KX_REGISTRY="portal.dl.kx.com"
    NAMESPACE="kxi-sdk"
    ```
1.  `imagePullSecrets` setup on your cluster
    ```bash
    kubectl create secret docker-registry kx-pull-secret --docker-username=$KX_USER --docker-password=$KX_PASS --docker-server=$KX_REGISTRY -n $NAMESPACE
    ```
1. A license secret
    _Contact KX to get a license_
    ```bash
    LIC_FILE=./kc.lic
    kubectl create secret generic kx-license --from-file=license=$LIC_FILE -n $NAMESPACE
    ```

1. A deployment specific values file associated with configurations relative to your deployment. Available configurations are documented in the chart and can be displayed by running

    ```bash
    # Run from `.../referenceArchitectures/kxi-ingest-transform-persist` directory
    helm show values .
    ```

    A sample config file is [provided](./config/kxi-ingest-transform-persist-values.yaml) but should be reviewed and updated to your configuration.
    - **NOTE:** Please ensure to set the `storageClassName` appropriately

### Deploying

The umbrella chart deploys an instance of InsightsDB chart and the `kxi-rt` RT message bus chart to allow data to be streamed into the database. As detailed in the [kxi-rt chart](../../kxCharts/kxi-rt/README.md#rt-streams-naming-conventions-and-discovery), the naming convention for the RT message bus deployment will be related to the `$RELEASENAME` used to deploy the chart, thus when prefixed with `rt-` deploys to `rt-$RELEASENAME`. Configuration for the RT stream is in the sample [config file](./config/kxi-ingest-transform-persist-values.yaml) must match the deployed RT name for discovery and ensure data flows into the database. These stream names are also illustrated in the diagram for clarity of this reference architecture.

```bash
# Run from '.../referenceArchitectures/kxi-ingest-transform-persist/' directory
helm dependency build

RELEASENAME=kxi-itp # Unique name for this deployment to deploy reference architecture
VALUESFILE=./config/kxi-ingest-transform-persist-values.yaml
NAMESPACE="kxi-sdk"
helm install $RELEASENAME . -f $VALUESFILE -n $NAMESPACE
```

At this point the reference architecture will have been successfully deployed, the next step should be to [deploy pipelines](#deploying-sp-pipelines) which will run within the cluster and generate test data

#### Configuration changes

Upgrading and updating of configuration is executed using `helm upgrade`. This will deploy any changes made to the charts or configuration since the last deploy and automatically redeploy the latest to the application

```bash
helm upgrade $RELEASENAME . -f $VALUESFILE -n $NAMESPACE
```

### Deploying SP pipelines

You can communicate with the SP Coordinator from outside the cluster using the kubectl port-forward command.

```bash
kubectl port-forward svc/$RELEASENAME-kxi-sp 5000:5000 -n $NAMESPACE &
```

Once you have port-forwarded, you can create pipelines by issuing HTTP POST requests using a similar command to the example below. This uses a sample data generator pipeline to publish data to the database

```bash
# Run from the '.../referenceArchitectures/kxi-ingest-transform-persist/' directory
SPEC_FILE=./spScripts/datagen.q
SP_URL=localhost:5000 # Assumes port forward. Update if NodePort or LoadBalancer
SP_NAME=kxi-itp-kxi-sp # Name of the SP Coordinator - $RELEASENAME-kxi-sp
DATA_PAYLOAD=$(
    jq -c -n --arg sp_name "$SP_NAME" --arg spec "$(cat $SPEC_FILE)" \
        '{ 
            name   : $sp_name, 
            type   : "spec", 
            config : { content: $spec },
            persistence : {
                controller : { class:"standard", size:"2Gi", checkpointFreq: 5000 },
                worker     : { class:"standard", size:"2Gi", checkpointFreq: 1000 }
            }
        }'
)
curl -X POST "http://$SP_URL/pipeline/create" \
    -H "Content-Type: application/json" \
    -d "$DATA_PAYLOAD"

# Teardown all pipelines
# curl -X POST "http://$SP_URL/pipelines/teardown"
```

Further information about writing and deploying pipelines, including a Quickstart walkthrough, can be found in the kdb Insights Stream Processor documentation on https://code.kx.com/insights/1.15/microservices/stream-processor/index.html.

At this point data can be [queried](#query-data-out) from the running system


### Data access

By default, KX reference architectures on Kubernetes do not expose external endpoints to the application and port forwarding is used to access the gateway. External access can be provided via Load Balancers. To enable external access points you can add the following configuration to the [config](./config/kxi-ingest-transform-persist-values.yaml) file as follows:


```yaml
...
# QUERY Interface
kxi-gw:
  service:
    type: LoadBalancer
    # type: NodePort
...
```

#### Querying data

Depending on whether you have enabled external access to the gateway or not, the URL used to access the gateway can be defined as follows:

- With external access points enabled using a `Loadbalancer`, the `$GW_URL` is set as follows:

    ```bash
    # Get the GW LoadBalancer url
    LB_HOST=`kubectl get svc $RELEASENAME-kxi-gw-sg -o jsonpath='{.status.loadBalancer.ingress[0].hostname}' -n $NAMESPACE`
    echo $LB_HOST
    GW_URL="$LB_HOST:8080"
    ```

- Without external access the `kxi-gw-sg` service requires port forwards to be able to access the gateway. The port forwards and `$GW_URL` are set as follows:

    ```bash
    # HTTP Port
    kubectl port-forward svc/$RELEASENAME-kxi-gw-sg 8080:8080 -n $NAMESPACE &
    # qIPC port
    kubectl port-forward svc/$RELEASENAME-kxi-gw-sg 5050:5050 -n $NAMESPACE &
    GW_URL="localhost:8080"
    ```


Now that `$GW_URL` is configured you can query data:

```bash
curl -X GET -H 'Content-Type: application/json' http://$GW_URL/data -d '{"table":"trade"}'
```


### Deploying with your own database assembly definition

The instructions above deploys reference architecture with a minimal database with a trade table defined in the [assembly.yaml](../../kxCharts/kxi-db/assembly.yaml) under `kxCharts/kxi-db/` directory. When you're ready to deploy your own assembly workload with your own schemas, you can provide your own yaml file.

1. Create your own assembly file `myassembly.yaml` in `kxCharts/kxi-db/` directory. Full info on creating database configurations [here](https://code.kx.com/insights/microservices/database/configuration/assembly/database.html)
1. Update the deployment [config](./config/kxi-ingest-transform-persist-values.yaml) to define the database configuration you wish to deploy
    ```
    ...
    kxi-db:
      assembly:
        filename: myassembly.yaml
    ...
    ```
1. Uninstall previous deployment if it is not done yet
   ```bash
      helm uninstall $RELEASENAME -n $NAMESPACE
   ```
1. Deploy again with your own database
   ```bash
   # Run from '.../referenceArchitectures/kxi-ingest-transform-persist/' directory
   helm dependency build

   RELEASENAME=kxi-itp # Unique name for this deployment to deploy reference architecture
   VALUESFILE=./config/kxi-ingest-transform-persist-values.yaml
   NAMESPACE="kxi-sdk"
   helm install $RELEASENAME . -f $VALUESFILE -n $NAMESPACE
   ```

### Cleaning up

The `kxi-ingest-transform-persist` reference architecture deployment can be deleted with helm as follows:

```bash
helm delete $RELEASENAME -n $NAMESPACE
```

By default the policy is to not delete associated volumes to allow it to be redeployed in the future and retain the data. If necessary these should be manually managed and deleted by the user.