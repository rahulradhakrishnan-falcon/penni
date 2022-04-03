terraform {
  required_version = "> 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.56"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
  profile = "default"
}

provider "aws" {
  region = "us-east-1"
  alias  = "acm_provider"
}