resource "kubernetes_namespace" "istio" {
  depends_on = [aws_eks_cluster.eks_cluster]
  
  metadata {
    name = "istio-system"
  }
}

resource "helm_release" "istio_base" {
  depends_on = [kubernetes_namespace.istio]
  
  name       = "istio-base"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "base"
  namespace  = "istio-system"

  set {
    name  = "global.istioNamespace"
    value = "istio-system"
  }
}

resource "helm_release" "istiod" {  
  depends_on = [helm_release.istio_base]
  name             = "istiod"
  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "istiod"
  namespace        = "istio-system"

  set {
    name  = "global.istioNamespace"
    value = "istio-system"
  }

  set {
    name  = "meshConfig.ingressService"
    value = "istio-gateway"
  }

  set {
    name  = "meshConfig.ingressSelector"
    value = "gateway"
  }
}

resource "helm_release" "gateway" {
  depends_on = [
    helm_release.istio_base,
    helm_release.istiod
  ]

  name             = "ingressgateway"
  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "gateway"
  namespace        = "istio-system"  
}