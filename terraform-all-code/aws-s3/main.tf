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
  region  = var.region
}
resource "random_id" "rand_id"{
    byte_length = 6
}


resource "aws_s3_bucket" "demo-bucket" {
    bucket = "my-terraform-storage-box-${random_id.rand_id.hex}"
}

resource "aws_s3_object" "demo-bucket-data" {
    bucket = aws_s3_bucket.demo-bucket.bucket
    source = "./text.txt"
    key    = "mydata.txt"
}
  

