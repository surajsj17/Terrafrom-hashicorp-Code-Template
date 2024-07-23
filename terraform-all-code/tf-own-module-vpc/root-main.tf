provider "aws" {
  region = "ap-south-1"
}

module "my-vpc" {
  source = "./module/vpc"
  
  vpc_config = {
    name  = "my-vpc"
    cidr_block = "10.0.0.0/16"
 }


subnet_config = {
  public_subnet={
    az = "ap-south-1a"
    cidr_block       = "10.0.1.0/24"
    name              = "public-subnet-1a"
    public = true
  }
  private_subnet={
    az = "ap-south-1a"
    cidr_block       = "10.0.100.0/24"
    name              = "private-subnet-1a"
  }
}
}