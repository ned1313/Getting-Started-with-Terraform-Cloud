terraform {
  required_version = ">1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

resource "aws_vpc" "space_coyote" {
  cidr_block           = var.address_space
  enable_dns_hostnames = true

  tags = {
    name        = "${var.prefix}-vpc-${var.region}"
    environment = var.environment
  }
}

resource "aws_subnet" "space_coyote" {
  vpc_id     = aws_vpc.space_coyote.id
  cidr_block = var.subnet_prefix

  tags = {
    name = "${var.prefix}-subnet"
  }
}

resource "aws_internet_gateway" "space_coyote" {
  vpc_id = aws_vpc.space_coyote.id

  tags = {
    Name = "${var.prefix}-internet-gateway"
  }
}

resource "aws_route_table" "space_coyote" {
  vpc_id = aws_vpc.space_coyote.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.space_coyote.id
  }
}

resource "aws_route_table_association" "space_coyote" {
  subnet_id      = aws_subnet.space_coyote.id
  route_table_id = aws_route_table.space_coyote.id
}