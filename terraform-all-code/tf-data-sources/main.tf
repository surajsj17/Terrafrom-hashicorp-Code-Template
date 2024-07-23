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
  region  = "ap-south-1"
}


resource "aws_instance" "nginxserver" {
  ami           = "ami-0ec0e125bb6c6e8ec"
  instance_type = "t3.micro"
  tags = {
    Name = "webserver"
  }
}
#  data "aws_ami" "ami_id_number" {
#     most_recent = true
#     owners = ["amazon"]
#     image_type = "CentOS"
   
#     filter {
#       name   = "name"
#       values = ["ebs"] 
#  }
#  }

# output "aws_ami" {
#     value = data.aws_ami.ami_id_number
# }

data "aws_ami" "centos" {
  most_recent = true
  owners      = ["679593333241"] # CentOS official owner ID

  filter {
    name   = "name"
    values = ["CentOS*"] # Wildcard to match any CentOS image
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

output "aws_ami_id" {
  value = data.aws_ami.centos.id
}
