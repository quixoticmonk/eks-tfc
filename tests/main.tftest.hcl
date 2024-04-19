mock_provider "aws" {
  alias = "mock_aws"

}

run "validate_variables" {
  command = plan
  providers = {
    aws = aws.mock_aws
  }

  variables {
    k8s_admin_role_arn = "arn:aws:iam:123456789012:role/tf_test"
    cluster_version    = "1.26"
  }
  expect_failures = [var.cluster_version]
}