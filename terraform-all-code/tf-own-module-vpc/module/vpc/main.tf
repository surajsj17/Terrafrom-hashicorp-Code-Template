resource "aws_vpc" "main" {
    cidr_block = var.vpc_config.cidr_block
    tags = {
      Name = var.vpc_config.name
    }
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  for_each = var.subnet_config
  availability_zone  = each.value.az
  cidr_block        = each.value.cidr_block

  tags = {
    Name = each.key
  }
  
}
locals{
  public_subnet = {
    for key , config in var.subnet_config : key => config if config.public
  }
}
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  count = length(local.public_subnet) > 0 ? 1 : 0

}