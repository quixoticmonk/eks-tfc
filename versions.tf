terraform {
  required_version = ">= 1.3.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.40"
    }
    newrelic = {
      source  = "newrelic/newrelic"
      version = "3.35.1"
    }

  }
}


provider "aws" {
  region = local.region
}
