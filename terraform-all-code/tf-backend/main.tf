terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
    backend "s3"{
       bucket = "my-terraform-storage-box-9469b96441c8"
       key = "backend.tfstate"
       region = "ap-south-1"
    }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "ap-south-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0ec0e125bb6c6e8ec"
  instance_type = "t2.micro"

  tags = {
    Name = "app_server"
  }
}