# Reference Architectures

A collection of reference applications built with Insights SDK software. These are quick start guides for docker and kubernetes, each provides information on how to get basic examples up and running. Full documentation for Insights SDK is available [here](https://code.kx.com/insights/microservices/index.html).

1. [Ingest And Persist](./kxi-ingest-persist)
1. [Ingest, Transform And Persist](./kxi-ingest-transform-persist)
1. [Sharded Multi-database](./kxi-sharded-databases)

## Kubernetes Prerequisites

There are a number of prerequisites which should be highlighted for the Kubernetes cluster due to the nature of cloud ephemeral deployments.

1. `helm` command installed on your local machine
1. A Distributed storage solution offering RWM access level. (Kubernetes docs for more [here](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes))
    - AWS offer [FSx for Lustre](https://aws.amazon.com/fsx/lustre/) Kubernetes compatible solution.
    - GCP offer [Managed Lustre](https://cloud.google.com/products/managed-lustre) with a [Kubernetes CSI driver](https://docs.cloud.google.com/kubernetes-engine/docs/concepts/managed-lustre)
    - Azure offer [Managed Lustre](https://azure.microsoft.com/en-us/products/managed-lustre) with a [Kubernetes CSI driver](https://learn.microsoft.com/en-us/azure/azure-managed-lustre/use-csi-driver-kubernetes)
    - [Rook-Cephfs](https://rook.io/docs/rook/v1.12/Storage-Configuration/Shared-Filesystem-CephFS/filesystem-storage/) can be deployed and client managed as a performant alternative to a managed distributed solution.

    It is vital that this RWM [StorageClass](https://kubernetes.io/docs/concepts/storage/storage-classes/) is available to allow the `kxi-db` chart to persist and access data offering the scalable features of the reference architecture. Each reference architecture will require the user to update their `kxi-db.db.*db.storageClassName`  in the `myvalues.yaml` to this RWM StorageClass to allow the database to successfully deploy.
