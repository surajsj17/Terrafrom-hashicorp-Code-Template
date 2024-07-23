output "aws_s3_bucket_name" {
    value = aws_s3_bucket.demo-bucket.bucket
}
output "aws_s3_bucket_object_name" {
     value = aws_s3_object.demo-bucket-data.key
}
  
output "name" {
    value = random_id.rand_id.hex
}