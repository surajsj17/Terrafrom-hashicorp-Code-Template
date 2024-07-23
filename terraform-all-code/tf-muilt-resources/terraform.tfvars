instance_name = [{
  ami = "ami-0ec0e125bb6c6e8ec"
  instance_type = "t3.micro"},{
  ami = "ami-0ad21ae1d0696ad58"
  instance_type = "t3.micro"
}]

map_config = {
  "ubuntu" = {
     ami = "ami-0ad21ae1d0696ad58"
     instance_type = "t3.micro"
  }

   "CentOS" = {
     ami = "ami-0ec0e125bb6c6e8ec"
     instance_type = "t3.micro"
  }
}