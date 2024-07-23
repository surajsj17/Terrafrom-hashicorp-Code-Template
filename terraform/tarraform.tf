variable  "region" {}
variable  "access_key" {}
variable  "secret_key" {}
variable "Name" {}

provider "aws" {
  region     = "ap-south-1"
  access_key = var.my-access-key
  secret_key = var.my-secret-key
}
resource "aws_instance" "example_instance" {
  ami           = var.my-ami
  instance_type = "t2.micro"

  tags = {
    Name = "My machine"
  }
}
variable "instance_count" {
  description = "Number of instances to create"
  default     = 1  # Change this value as needed
}

terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "your-terraform-state-key"
    region         = "ap-south-1"
    dynamodb_table = "your-dynamodb-lock-table"
  }
}


# resource "aws_s3_bucket" "example" {
#   bucket = "your-terraform-state-bucket"
#   acl    = "private"
#   # ... add more configuration as needed
# }

resource "aws_dynamodb_table" "lock_table" {
  name           = "your-dynamodb-lock-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  # ... add more configuration as needed
}
