terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = var.region
}

resource "aws_instance" "app_server" {
  ami           = "ami-0b72821e2f351e396"
  instance_type = "t2.micro"

  tags = {
    Name = "app_server"
  }
}


