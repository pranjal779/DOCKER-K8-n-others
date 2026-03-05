
Helm charts are essentially collections of templated Kubernetes manifest files (YAML) packaged together.
They are used to simplify application deployment, enable easy updates/rollbacks, manage configuration across different environments, and reduce code duplication in Kubernetes. 

Key Aspects of Helm Charts:
Templates (/templates): The directory containing YAML files (deployments, services, ingress) that use placeholders (Go templating) for variable data.
values.yaml: The file containing default configuration values, which are injected into the templates during deployment.
Chart.yaml: Contains metadata (name, version, description) about the package.
Purpose: Instead of managing dozens of individual YAML files, Helm allows you to treat a set of Kubernetes resources as a single unit (a release) for installation, upgrades, and version control. 


In short, Helm transforms static Kubernetes manifests into dynamic, reusable, and versioned application packages.
