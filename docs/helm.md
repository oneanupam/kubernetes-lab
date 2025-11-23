# 📘 Helm Commands Reference
This repository contains a curated list of essential `helm` commands for managing Kubernetes packages efficently. Useful for daily reference and quick lookups.

---

## 🧱 Useful Commands

```bash
# 1. Helm Config Management
helm --help | helm command --help | helm command subcommand --help # to get the help
helm version # Check the installed kubectl client version
helm env # to print out all the environment variables used by Helm

# 2. Helm Chart Management
helm repo
helm search
helm registry login/logout # to login/logout to helm registry
helm pull # to pull a helm chart from the registry.
helm push # to push a helm chart from the registry.
helm create chart-name # this command generates a template chart.
helm package chart-name # package the Helm chart into a tarball.

helm template [RELEASE_NAME] [CHART_NAME] # to render chart templates locally and display the output. typically used for testing the charts locally.
helm show all [CHART] [flags] # to inspect a chart (directory, file, or URL) and displays all its content (values.yaml, Chart.yaml, README)

helm install [RELEASE_NAME] [CHART_NAME] [flags] # to install a chart. you can pass the supported flags, say to pass the custom values, use, -f values.yaml or use --version to use a specific chart version to install.
helm get all [RELEASE_NAME] [flags] # to get all the information about the notes, hooks, supplied values, and generated manifest file of the given release.
helm upgrade [RELEASE_NAME] [CHART_NAME] [flags] # to upgrade an existing release. use --install flag if a release doesn't already exist.
helm list # this command lists all of the releases (of any status) for a specified namespace (uses current namespace context if namespace not specified).
helm history [RELEASE_NAME] [flags] # to print the release history of a given release like how many revisions have been deployed etc.
helm status [RELEASE_NAME] [flags] # to show the status of a named release
helm rollback [RELEASE_NAME] [REVISION] [flags] # to roll back a release to a previous revision
helm uninstall [RELEASE_NAME] # this command is used to uninstall/delete the release

helm lint # This command takes a path to a chart and runs a series of tests to verify that the chart is well-formed. If the linter encounters things that will cause the chart to fail installation, it will emit [ERROR] messages. If it encounters issues that break with convention or recommendation, it will emit [WARNING] messages.
helm test [RELEASE_NAME] [flags] # to run the tests for a release

# What's new in Helm v4.0.0?
# 1. Error Messages: Clearer, more helpful error output.
# 2. CLI Flags renamed: Some common CLI flags are renamed to better clarify their operation. The existing flags remain, but emit a deprecated warning:
# --atomic → --rollback-on-failure
# --force → --force-replace
```

## 📌 How to Contribute
Feel free to fork this repo and add your favorite helm commands!

## References
- https://helm.sh/docs/helm/
- https://helm.sh/docs/helm/helm
- https://helm.sh/docs/topics/registries
- https://helm.sh/docs/topics/chart_tests
- https://helm.sh/docs/topics/charts_hooks
- https://docs.cloud.google.com/artifact-registry/docs/helm/store-helm-charts
- https://helm.sh/docs/overview#whats-new
