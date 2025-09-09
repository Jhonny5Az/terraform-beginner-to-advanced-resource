terraform {
  required_version = "1.13"
  required_providers {
    aws = {
        version = ">= 6.12.0"
        source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}
