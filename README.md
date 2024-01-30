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
    - iac-scan (vulnerability scan for kubernetes manifests using Checkov)
    - deploy-code (code is pushed to gitlab repo)
    - deploy-app (argocd application file is applied to eks cluster)
    - delete (option to delete application form eks cluster)
    
  - Created Service Account for the Load Balancer
  - Installed Helm chart for the AWS Load Balancer Controller
      - https://artifacthub.io/packages/helm/aws/aws-load-balancer-controller/
  - Kube-bench runs security audit against CIS Kubernetes Benchmark

  ## Cloud Native security:
  ![](https://github.com/smithashley/Kubernetes-Deployment-2/blob/main/embedded-images/k8-security.png)
  https://kubernetes.io/docs/concepts/security/overview/
  
- This project integrates security at each layer: code, container, cluster, and cloud.
  - The CI/CD pipeline for the deployment contains a scan of the image container, code quality checks, and security checks of the manifests.
  - The containers are also secured at the pod level through, security contexts, network policies, restricted pod access to instance metadata service, and RBAC. 
  - The cluster is also secured through the Istio service mesh as well as writing audit logs to S3 to monitor the cluster with AWS GuardDuty for runtime security.
  -	The cloud enviroment is secured through this multi-layered security approach. Firstly, security groups control network access to resources, offering a basic layer of firewall protection. Secondly, a load balancer behind an Istio service mesh enhances application resiliency and security by providing additional traffic management and microservices protection capabilities.
