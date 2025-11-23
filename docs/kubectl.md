# 📘 kubectl Commands Reference
This repository contains a curated list of essential `kubectl` commands for managing Kubernetes clusters efficiently. Useful for daily reference and quick lookups.

---

## 🧱 Useful Commands

```bash
# 1. Config Management
alias k=kubectl # Temporary alias (works only in the current terminal)
kubectl config -h # Get the kubectl commands help and examples
kubectl version --client # Check the installed kubectl client version
kubectl config view # View the current kubeconfig settings
kubectl config get-contexts # Get all the contexts
kubectl config current-context # Show the current active Kubernetes context
kubectl config use-context <context-name> # Switch to a different Kubernetes context

# 2. Core Objects Management
kubectl apply -f pod-definition.yaml # to apply the pod manifest file.
kubectl get pods -n namespace # to list the pods in defined namespace. Use --all-namespaces to get the result for all the namespaces.
kubectl get pods -l app=frontend,env=prod | kubectl get pods --selector app=frontend,env=prod # get the pods having specific labels.
kubectl get pods --all-namespaces -o wide # to list the pods in all the namespace with more details like node etc.
kubectl describe pod pod-name # to show all the details of the given pod.
kubectl delete pod pod-name # to delete a pod in current namespace.
kubectl delete pod --all # to delete all pods in current namespace.
kubectl delete -f pod.yaml # Delete a pod using the type and name specified in the pod.yaml file.
kubectl get pod pod-name -o yaml > pod-definition.yaml # to store the running pod definition to a yaml file.
kubectl edit pod pod-name # The edit command allows you to directly edit any API resource you can retrieve via the command-line tools. It will open the editor defined by your KUBE_EDITOR, or EDITOR environment variables, or fall back to 'vi' for Linux or 'notepad' for Windows. In the event an error occurs while updating, a temporary file will be created on disk that contains your unapplied changes.

kubectl get replicasets # to list the pods in current namespace.
kubectl describe replicaset replicaset-name
kubectl delete replicasets replicaset-name # to delete the replicaset in current namespace.

kubectl apply -f deployment.yaml # to create a deployment. Please note, for every deployment, there is a new replicaset gets created to maintain the history. Deployment status can be checked using rollout status command.
kubectl get deployments # to list the deployment objects in current namespace.
kubectl describe deployment deployment-name
kubectl delete replicasets replicaset-name # to delete the deployment in current namespace.

kubectl rollout history deployment/deployment-name # to see the rollout history of the a deployment
kubectl rollout status deployment/deployment-name # to see the rollout status of a current change of the a deployment
kubectl rollout undo deployment/deployment-name # to undo a rollout to last revision
kubectl rollout status deployment/deployment-name --to-revision=<revision-number> # to undo a rollout to specific revision

kubectl get services # to list all the services
kubectl get endpoints service-name # to get all the endpoints of a service
kubectl delete service service-name # to delete a service
kubectl delete pods,services -l <label-key>=<label-value> # Delete all the pods and services that have the label '<label-key>=<label-value>'.

# Types of services
# 1. Node Port: A NodePort Service exposes a port on each Kubernetes node, and any request sent to that port is forwarded to the Service port, which then routes it to the target port on the Pod. The nodePort is in the range 30000–32767. Visual representation below -
# Client → Node:30080 → NodePort Service:80 → Pod:8080
# Service Endpoints:
# nodeip:nodeport (accessible from outside the cluster)
# nodeport-service-ip:service-port (accessible from inside the cluster only)

# 2. Cluster IP: This type of service exposes the pods internally only. Hence not accessible from outside of the cluster.
# Service Endpoints:
# myapp-cip-service.default.svc.cluster.local:service-port
# cip-service-ip:service-port

# 3. Load Balancer: This type of service creates a public cloud load balancer (GCP: L4 External Load Balancer) and Gets an external IP address, then sends incoming traffic → to the Service → then to Pods

# 4. Headless Service:

# Note: Every normal Service created in Kubernetes gets a ClusterIP (an internal IP) assigned to it.

kubetcl get all # to get all the created objects
kubectl get events # to get the events of all the namespaces
kubectl get events -n namespace # to get the events of a specific namespace
kubectl get events -n <namespace> --sort-by=.lastTimestamp # sorted events of a namespace

kubectl exec <pod-name> -- date # Get output from running 'date' from pod <pod-name>. By default, output is from the first container.
kubectl exec <pod-name> -c <container-name> -- date # Get output from running 'date' in container <container-name> of pod <pod-name>.
kubectl exec -it <pod-name> -- /bin/bash # Get an interactive TTY and run /bin/bash from pod <pod-name>. By default, output is from the first container.

kubectl logs <pod-name> # Return a snapshot of the logs from pod <pod-name>.
kubectl logs -f <pod-name> # Start streaming the logs from pod <pod-name>. This is similar to the 'tail -f' Linux command.
```

## 📌 How to Contribute
Feel free to fork this repo and add your favorite kubectl commands!

## References
- https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands
- https://kubernetes.io/docs/reference/kubectl/#resource-types
