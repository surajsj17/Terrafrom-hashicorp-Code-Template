provider "aws" {
  region  = "ap-south-1"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.9.0"


 name = "my-vpc"
 cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"] 

  

  tags = {
    Name = "webapp"
  }

}