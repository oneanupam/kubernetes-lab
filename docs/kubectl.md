# 📘 kubectl Commands Reference

This repository contains a curated list of essential `kubectl` commands for managing Kubernetes clusters efficiently. Useful for daily reference and quick lookups.

---

## 🧱 Useful Commands

```bash
# Get the kubectl commands help and examples
kubectl config -h

# Check the installed kubectl client version
kubectl version --client

# View the current kubeconfig settings
kubectl config view

# Get all the contexts and show the current active Kubernetes context
kubectl config get-contexts
kubectl config current-context

# Switch to a different Kubernetes context
kubectl config use-context <context-name>
```

## 📌 How to Contribute

Feel free to fork this repo and add your favorite kubectl commands!
