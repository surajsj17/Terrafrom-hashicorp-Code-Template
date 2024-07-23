terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
     random = {
      source = "hashicorp/random"
      version = "3.6.2"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "ap-south-1"
}
resource "random_id" "rand_id"{
    byte_length = 6
}


resource "aws_s3_bucket" "demo-bucket" {
    bucket = "my-terraform-storage-box-${terraform.workspace}-${random_id.rand_id.hex}"
}

 

