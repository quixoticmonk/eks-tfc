locals {
  name            = "marketplace-webinar"
  cluster_version = var.cluster_version
  region          = "us-east-1"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    create_by = "manuchn"
    product   = "marketplace-webinar"
  }
}


data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {}

data "aws_eks_addon_version" "nr" {
  addon_name         = "new-relic_kubernetes-operator"
  kubernetes_version = local.cluster_version
}