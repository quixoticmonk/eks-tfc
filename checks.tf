check "health_check" {
  data "http" "check_url" {
    url = "https://www.terraform.io"
  }

  assert {
    condition     = data.http.terraform_io.status_code == 200
    error_message = "${data.http.terraform_io.url} returned an unhealthy status code"
  }
}


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
    error_message = "Addon version is ${data.aws_eks_addon.nr.addon_version}"
  }
}


check "newrelic_addon_version" {

  data "aws_eks_addon" "nr" {
    addon_name   = "new-relic_kubernetes-operator"
    cluster_name = local.name
  }


  assert {
    condition     = data.aws_eks_addon.nr.addon_version == "v0.1.8-eksbuild.1"
    error_message = "Addon version is ${data.aws_eks_addon.nr.addon_version}"
  }
}