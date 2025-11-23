# Kubernetes Lab
This repository contains kubernetes manifest files to deploy various kubernetes objects for learning and testing different K8S concepts.

## Prerequisites
Below prerequisites must be fulfilled for successful execution of provided manifests.

### K8S Cluster Requirement
You can setup the kubernetes cluster in different ways. Few popular ways are MiniKube or KinD for installing it swiftly for testing purposes.

### Software Requirement
Manifests in this repository are meant to use with Kubernetes version 1.30.5 on your Kubernetes Cluster. Below additional tools are required based on the setup.

- [Cloud SDK](https://cloud.google.com/sdk/install) >= 548.0.0
- [Kubectl](https://kubernetes.io/docs/tasks/tools/) >= v1.33.5

> [!NOTE]
> See [Installation Guide](https://kubernetes.io/docs/tasks/tools/) on how to install Kubernetes Tools.

## K8S Manifest Execution
To execute the manifest files, go to command prompt and then run the following commands:

- `kubectl version` # To get the version of kubectl clinet, server and Kustomize.
- `kubectl apply -f manifest.yaml` # To apply a manifest configuration.
- `kubectl get pods -n default` # To get the pods in a default namespace.
- `kubectl get pods -o wide --all-namespace` # To get the pods in all the namespaces.
- `kubectl top nodes/pods` # To get the resource usage metrics, such as CPU and memory, for Kubernetes nodes or pods.

> [!TIP]
> See the [Kubectl documentation](https://kubernetes.io/docs/reference/kubectl/) for full list of commands.

## Contributing
Contributions are welcome! Please open issues or submit pull requests for improvements or new suggestions. Read the [contributing.md](CONTRIBUTING.md) before starting.

## References
- https://kubernetes.io/docs/concepts/
- https://kubernetes.io/docs/reference/kubectl/
- https://kubernetes.io/docs/reference/kubernetes-api/
- https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.30/
