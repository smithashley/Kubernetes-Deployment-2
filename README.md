# Kubernetes-Deployment-2
DevSecOps processes are used to deploy a secure application with persistent storage on an EKS cluster.

## Steps
- Configured VPC, Subnets, and Security Groups using CloudFormation
- Deployed EKS cluster using CloudFormation
- Created namespaces to isolate resources
- Installed Helm
    - https://helm.sh/ 
- Installed Helm chart for ArgoCD 
    - https://artifacthub.io/packages/helm/argo/argocd-apps/

Custom Object 
```
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: stateful-app
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/smithashley/Kubernetes-Deployment-2.git
    targetRevision: HEAD
    path: website
  destination:
    server: https://kubernetes.default.svc
    namespace: staging
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
      allowEmpty: false     
```
    
  - Created Service Account for the Load Balancer
  - Installed Helm chart for the AWS Load Balancer Controller
      - https://artifacthub.io/packages/helm/aws/aws-load-balancer-controller/
   
  ## Cloud Native security:
  ![](https://github.com/smithashley/Kubernetes-Deployment-2/blob/main/embedded-images/k8-security.PNG)
- This project integrates security at each layer: code, container, cluster, and cloud.
  - The CI/CD pipeline for the cluster contains code quality checks and security checks of the template and the CI/CD pipeline for the deployment contains a scan of the image container, code quality checks, and       security checks of the template.
  - The containers are also secured at the pod level through, securityCapabilities, SGs, restricted pod access to instance metadata service, network policy to restrict network traffic within cluster and RBAC. 
  - The cluster is also secured by making the endpoint private/Deny all global policy, write audit logs to S3 to monitor the cluster with AWS GuardDuty to detect potentially suspicious activities through              configuration changes.
  -	The API is secured in the cloud with a Web Application Firewall.

