resource "aws_instance" "thesis_server" {
  ami           = "ami-03484a09b43a06725"
  instance_type = "t2.micro"

  tags = {
    Name = "exampleserver"
  }
}



resource "aws_vpc" "this" {

  for_each             = var.vpc_parameters

  cidr_block           = each.value.cidr_block

  enable_dns_support   = each.value.enable_dns_support

  enable_dns_hostnames = each.value.enable_dns_hostnames

  tags = merge(each.value.tags, {

    Name : each.key

  })

}



resource "aws_subnet" "this" {

  for_each   = var.subnet_parameters

  vpc_id     = aws_vpc.this[each.value.vpc_name].id

  cidr_block = each.value.cidr_block

  tags = merge(each.value.tags, {

    Name : each.key

  })

}



resource "aws_internet_gateway" "this" {

  for_each = var.internet_gatway_parameters

  vpc_id   = aws_vpc.this[each.value.vpc_name].id

  tags = merge(each.value.tags, {

    Name : each.key

  })

}



resource "aws_route_table" "this" {

  for_each = var.route_table_parameters

  vpc_id   = aws_vpc.this[each.value.vpc_name].id

  tags = merge(each.value.tags, {

    Name : each.key

  })



  dynamic "route" {

    for_each = each.value.routes

    content {

      cidr_block = route.value.cidr_block

      gateway_id = route.value.use_igw ? aws_internet_gateway.this[route.value.gateway_id].id : route.value.gateway_id

    }

  }

}



resource "aws_route_table_association" "this" {

  for_each       = var.route_table_association_parameters

  subnet_id      = aws_subnet.this[each.value.subnet_name].id

  route_table_id = aws_route_table.this[each.value.rt_name].id

}
provider "aws" {
  region = var.region
}
