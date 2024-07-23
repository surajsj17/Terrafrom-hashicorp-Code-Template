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


#VPC
resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "${local.project}-vpc"
    }
}

locals{
    project = "my_project"
}
#public subnet

resource "aws_subnet" "public-subnet" {
    cidr_block = "10.0.${count.index}.0/24"
    vpc_id = aws_vpc.my-vpc.id
    count = 2

    tags = {
        Name = "${local.project}-public-subnet${count.index}"
    }
}


output "aws_subnet_access" {
    value = aws_subnet.public-subnet[0].id
}

locals {
   instance_name = "my-virtual-machine"
}


# resource "aws_instance" "website2" {
#     count = length(var.instance_name)
#     ami           = var.instance_name[count.index].ami 
#     instance_type = var.instance_name[count.index].instance_type
#     subnet_id      = element(aws_subnet.public-subnet[*].id,count.index % length(aws_subnet.public-subnet))
#     tags = {

#         Name = "${local.instance_name}-2${count.index}"
#     }
# }



resource "aws_instance" "website2" {
    for_each = var.map_config
    ami           =  each.value.ami
    instance_type =  each.value.instance_type
    subnet_id      = element(aws_subnet.public-subnet[*].id, index(keys(var.map_config),each.key) % length(aws_subnet.public-subnet))
    tags = {

        Name = "${local.instance_name}-{each.key}"
    }
}


# output "aws_instance_ids" {
#   value = aws_instance.website2[*].id
# }

# output "aws_subnet_ids" {
#   value = aws_subnet.public-subnet[*].id
# }
