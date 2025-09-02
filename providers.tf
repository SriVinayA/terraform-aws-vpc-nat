provider "aws" {
  region = "us-east-2"
  profile = "default"
}

terraform {
  required_version = ">= 1.12.0"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.7.2"
    }
  }
}