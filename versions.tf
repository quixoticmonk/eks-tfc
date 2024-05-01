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


provider "newrelic" {
  api_key    = var.nr_apikey
  account_id = var.nr_account_id
}