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

data "aws_eks_cluster" "cluster" {
  name= module.eks.cluster_name
  lifecycle {
    postcondition {
      condition = self.cluster_version==local.cluster_version
      error_message = "The cluster version is set to ${self.cluster_version}"
    }
        postcondition {
      condition = self.cluster_name==local.name
      error_message = "The cluster version is set to ${self.cluster_name}"
    }
  }


}