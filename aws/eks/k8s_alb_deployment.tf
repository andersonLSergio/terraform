resource "kubernetes_deployment" "alb-ingress" {
  metadata {
    name = "alb-ingress-controller"
    labels = {
      "app.kubernetes.io/name" = "alb-ingress-controller"
    }
    namespace = "kube-system"
  }

  spec {
    selector {
      match_labels = {
        "app.kubernetes.io/name" = "alb-ingress-controller"
      }
    }

    template {
      metadata {
        labels = {
          "app.kubernetes.io/name" = "alb-ingress-controller"
        }
      }
      spec {
        volume {
          name = kubernetes_service_account.alb-ingress.default_secret_name
          secret {
            secret_name = kubernetes_service_account.alb-ingress.default_secret_name
          }
        }
        container {
          image = "docker.io/amazon/aws-alb-ingress-controller:${var.alb_ingress_ctrl_version}"
          name  = "alb-ingress-controller"
          args = ["--ingress-class=alb",
            "--cluster-name=${aws_eks_cluster.tf_eks.name}",
            "--aws-vpc-id=${var.vpc_id}",
            "--aws-region=${var.aws_region}"]
          volume_mount {
            name       = kubernetes_service_account.alb-ingress.default_secret_name
            mount_path = "/var/run/secrets/kubernetes.io/serviceaccount"
            read_only  = true
          }
        }
        service_account_name = "alb-ingress-controller"
      }
    }
  }
}