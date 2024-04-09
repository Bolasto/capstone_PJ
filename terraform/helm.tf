####################Create ArgoCD Namespace####################
####################PLEASE MAKE SURE YOUR CLUSTER IS CREATED BEFORE DEPLOYING THIS FILE####################

resource "helm_release" "argocd" {
  count = local.create_workloads == true ? 1 : 0 

  name       = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "6.7.10"

  #   namespace = kubernetes_namespace.argocd[0].metadata[0].name
  namespace        = "argocd"
  create_namespace = true

  values = [
    templatefile("values/argocd-values.yaml", { env = var.env })
  ]
}

####################Create ArgoCD Apps####################

resource "helm_release" "argocd_apps" {
  count = local.create_workloads == true ? 1 : 0

  name       = "argocd-apps"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argocd-apps"
  version    = "2.0.0"

  #   namespace = kubernetes_namespace.argocd[0].metadata[0].name
  namespace        = "argocd"
  create_namespace = true

  values = [
    templatefile("values/argocd-apps.yaml", { env = var.env })
  ]

  depends_on = [
    helm_release.argocd
  ]
}
####################Create ArgoCD Apps####################