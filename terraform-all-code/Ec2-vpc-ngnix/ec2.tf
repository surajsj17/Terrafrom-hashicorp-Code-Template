resource "aws_instance" "nginxserver" {
  ami           = "ami-0ec0e125bb6c6e8ec"
  instance_type = "t3.micro"
  subnet_id      = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.sg-1.id]
  associate_public_ip_address = true

  user_data =  <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install nginx -y
                sudo systemctl start nginx
                sudo systemctl enable nginx
                sudo echo 'Hello, World!' > /var/www/html/index.html
                EOF
  tags = {
    Name = "webserver"
  }
}

