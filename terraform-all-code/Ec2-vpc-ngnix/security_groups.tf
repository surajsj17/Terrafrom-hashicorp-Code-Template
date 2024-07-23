resource "aws_security_group" "sg-1" {
  vpc_id = aws_vpc.my-vpc.id
  description = "This is the AWS Security Group"

  #Inbound rule for http
  
  ingress{
    from_port = 80 
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  # Outbound rule for http

  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow outbound traffic"
  }

    tags ={
         Name = "sg_nginx"
    } 
}