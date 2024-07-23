output "instance_name" {
    value = aws_instance.nginxserver.id
}

output "instance_public_ip" {
  value = aws_instance.nginxserver.public_ip
}

output "instance_url" {
  description = "URL to access the Nginx web server"
  value = "http://${aws_instance.nginxserver.public_ip}"
}