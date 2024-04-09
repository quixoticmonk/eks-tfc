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
  name = module.eks.cluster_name
  lifecycle {
    postcondition {
      condition     = self.status == "ACTIVE"
      error_message = "The cluster status is ${self.status}"
    }
    postcondition {
      condition     = self.name == local.name
      error_message = "The cluster version is set to ${self.name}"
    }

    postcondition {
      condition     = self.version == local.cluster_version
      error_message = "The cluster version is set to ${self.version}"
    }
  }

}


data "aws_kms_key" "key" {
  key_id = module.ebs_kms_key.key_id

  lifecycle {
    postcondition {
      condition = self.enabled==true
      error_message = "The KMS key is not in an Enabled state"
    }
  }
  
}