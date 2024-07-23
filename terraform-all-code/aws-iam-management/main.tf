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

locals {
  users_data = yamldecode(file("./users.yaml")).users
}

output "user_info" {
  value = local.users_data[*].username
}


resource "aws_iam_user" "main" {
  for_each = toset(local.users_data[*].username)
  name = each.value
}


resource "aws_iam_user_login_profile" "password" {
  for_each = aws_iam_user.main
  user    = each.value.name
  password_length = 20

  
lifecycle {
    ignore_changes = [
    password_length,
    password_reset_required,
    pgp_key,
    ]
  }
}


output "password" {
  value = aws_iam_user_login_profile.password

