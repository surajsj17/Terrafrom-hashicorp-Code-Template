terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
     random = {
      source = "hashicorp/random"
      version = "3.6.2"
    }
  }
   backend "s3"{
       bucket = "myweb-application-382a6c2f0675"
       key = "backend.tfstate"
       region = "ap-south-1"
    }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "ap-south-1"
}
resource "random_id" "rand_id"{
    byte_length = 6
}


resource "aws_s3_bucket" "myweb-app" {
    bucket = "myweb-application-${random_id.rand_id.hex}"
}

resource "aws_s3_object" "index_html" {
    bucket = aws_s3_bucket.myweb-app.bucket
    source = "./index.html"
    key    = "index.html"
    content_type = "text/html"
}
resource "aws_s3_object" "styles_css" {
    bucket = aws_s3_bucket.myweb-app.bucket
    source = "./styles.css"
    key    = "styles.css"
    content_type = "text/css"
}
  
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.myweb-app.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
resource "aws_s3_bucket_policy" "mywebapps" {
  bucket = aws_s3_bucket.myweb-app.id
  policy = jsonencode(
    {
  Version = "2012-10-17",
  Statement = [
    {
       Sid =  "PublicReadGetObject",
       Effect = "Allow",
       Principal = "*",
       Action =  "s3:GetObject",
       Resource = "arn:aws:s3:::${aws_s3_bucket.myweb-app.id}/*"
    }
  ]
}
  )
}


resource "aws_s3_bucket_website_configuration" "mywebapp" {
  bucket = aws_s3_bucket.myweb-app.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

output "s3_web_url" {
    value = aws_s3_bucket_website_configuration.mywebapp.website_endpoint
}