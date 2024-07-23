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
        Name = "My_VPC"
    }
}

#public subnet

resource "aws_subnet" "public-subnet" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.my-vpc.id
    map_public_ip_on_launch = true 
    tags = {
        Name = "Public_Subnet"
    }
}


#private subnet
resource "aws_subnet" "private-subnet" {
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.my-vpc.id

    tags = {
        Name = "Private_Subnet"
    }
}

#internet gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.my-vpc.id

    tags = {
        Name = "My_IGW"
    }
}

#route table

resource "aws_route_table" "public-route-table" {
    vpc_id = aws_vpc.my-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

}

resource "aws_route_table_association" "public-route-table-association"{
    subnet_id      = aws_subnet.public-subnet.id
    route_table_id = aws_route_table.public-route-table.id
}

resource "aws_instance" "app_servers" {
  ami           = "ami-0ec0e125bb6c6e8ec"
  instance_type = "t3.micro"
  subnet_id      = aws_subnet.public-subnet.id
  tags = {
    Name = "app_server"
  }
}