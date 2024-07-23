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


resource "aws_security_group" "sg" {
    vpc_id = aws_vpc.network.id
    name        = "example-sg"
    description = "Example security group"

    ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.network.id
    cidr_block = "10.0.1.0/24"
}

resource "aws_vpc" "network" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "aws_vpc"
    }
}

resource "aws_instance" "main" {
    ami           = "ami-0ec0e125bb6c6e8ec"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.private.id
    associate_public_ip_address = true
    depends_on = [ aws_security_group.sg ]

    # lifecycle {
    #   create_before_destroy = true
    #   prevent_destroy = true
    #   replace_triggered_by = [ aws_security_group.sg ,ingress]
    # }

    lifecycle {
      precondition {
        condition = aws_security_group.sg != ""
        error_message = "There is blank name of sg"
      }
      postcondition {
        condition = self.public_ip != ""
        error_message = "there is no public ip generated"
      }
    }
}