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
  instance_type = var.aws_instance_type
  
  root_block_device {

    delete_on_termination = true
    volume_size = var.root_block_device_variable.volume_size
    volume_type = var.root_block_device_variable.volume_type
}
  tags = merge(var.names, 
  {
    Name = "Webserver"
  })

}