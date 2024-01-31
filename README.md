# Kubernetes-Deployment-2
DevSecOps processes are used to deploy an application on an EKS cluster.

## Steps
- Configured VPC, Subnets, and Security Groups using Terraform
- Deployed EKS cluster using Terraform
- Created namespaces to isolate resources
- Installed Helm
    - https://helm.sh/ 
- Installed Helm chart for ArgoCD 
    - https://artifacthub.io/packages/helm/argo/argocd-apps/
- Created CI pipeline using Gitlab with the following stages
    - pull-source-code (pulls source code from github)
    - image-scan (vulnerability scan for container image using Trivy)
    - iac-scan (static code analysis scan for kubernetes manifests using Checkov)
    - deploy-code (code is pushed to gitlab repo)
    - deploy-app (argocd application file is applied to eks cluster)
    - delete (option to delete the application from the eks cluster)
 - Installed Helm chart for the Istio Gateway
    - https://artifacthub.io/packages/helm/istio-official/gateway
  - Kube-bench runs security audit against CIS Kubernetes Benchmark

  ## Cloud Native security:
  ![](https://github.com/smithashley/Kubernetes-Deployment-2/blob/main/embedded-images/k8-security.png)
  https://kubernetes.io/docs/concepts/security/overview/
  
- This project integrates security at each layer: code, container, cluster, and cloud.
  - The CI/CD pipeline requires a vulnerability scan of the container image and static code analysis (SAST) scan of the manifests before deploying the application to the cluster.
  - The containers are secured at the pod level through security contexts, network policies, and role based access control. 
  - The cluster is secured by using audit logs to monitor the cluster with AWS GuardDuty for runtime security.
  -	The cloud enviroment is secured through security groups controlling network access to resources as well as using a proxy to route inbound traffic.
