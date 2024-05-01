# Adding New Relic addon from the marketplace

resource "aws_eks_addon" "newrelic_addon" {
  depends_on    = [module.eks]
  addon_name    = "new-relic_kubernetes-operator"
  cluster_name  = module.eks.cluster_name
  addon_version = "v0.1.8-eksbuild.1"

  lifecycle {

    precondition {
      condition     = module.eks.cluster_status == "ACTIVE"
      error_message = "Cluster should be active"
    }

    precondition {
      condition     = module.eks.cluster_version == local.cluster_version
      error_message = "Cluster version should 1.28"
    }
    precondition {
      condition     = module.eks.cloudwatch_log_group_name == "/aws/eks/${local.name}/cluster"
      error_message = "Cloudwatch log group should contain the cluster name"
    }
    ignore_changes = [addon_version]
  }
}


resource "newrelic_one_dashboard_json" "k8s_dash" {
     json = templatefile("${path.module}/templates/infra_dashboard.tftpl",{account_id=var.nr_account_id})
}

resource "newrelic_one_dashboard_json" "k8s_logs" {
     json = templatefile("${path.module}/templates/log_ingestion.tftpl",{account_id=var.nr_account_id})
}