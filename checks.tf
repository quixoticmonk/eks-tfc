check "cluster_status" {

  assert {
    condition     = module.eks.cluster_status == "ACTIVE"
    error_message = "The cluster status is ${module.eks.cluster_status}"
  }
}

check "cluster_version" {

  assert {
    condition     = module.eks.cluster_version == var.cluster_version
    error_message = "The cluster version is ${module.eks.cluster_version}"
  }
}


check "access_config" {

  data "aws_eks_cluster" "this" {
    name = local.name
  }

  assert {
    condition     = data.aws_eks_cluster.this.access_config[0].authentication_mode == "API_AND_CONFIG_MAP"
    error_message = "Both API and config map are not present on auth mode"
  }
}


check "newrelic_addon_version" {

  data "aws_eks_addon" "nr" {
    addon_name   = "new-relic_kubernetes-operator"
    cluster_name = local.name
  }


  assert {
    condition     = data.aws_eks_addon.nr.addon_version == "v0.1.8-eksbuild.1"
    error_message = "Latest addon version for New Relic is ${data.aws_eks_addon.nr.addon_version}"
  }
}

check "ssh_ingress_rules" {

  assert {
    condition     = aws_security_group.remote_access.ingress[*].cidr_blocks == ["10.0.0.0/8"]
    error_message = "The ssh ingress cidr blocks have changed"
  }
}

check "key_pair_exists" {

  assert {
    condition     = module.key_pair.key_pair_name == local.name
    error_message = "The key pair by the name ${local.name} doesn't exist"
  }
}

check "kms_key_status" {

  data "aws_kms_key" "this" {
    key_id = module.ebs_kms_key.key_id

  }

  assert {
    condition     = data.aws_kms_key.this.enabled == true
    error_message = "The required KMS key is not in Enabled state"
  }
}


