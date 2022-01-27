terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Owner       = "Globomantics"
      Project     = var.project
      Environment = var.environment
    }
  }
}


resource "aws_vpc" "diamond_dogs" {
  cidr_block           = var.address_space
  enable_dns_hostnames = true

  tags = {
    name        = "${var.prefix}-vpc-${var.region}"
    environment = var.environment
  }
}

resource "aws_subnet" "diamond_dogs" {
  vpc_id     = aws_vpc.diamond_dogs.id
  cidr_block = var.subnet_prefix

  tags = {
    name = "${var.prefix}-subnet"
  }
}

resource "aws_security_group" "diamond_dogs" {
  name = "${var.prefix}-security-group"

  vpc_id = aws_vpc.diamond_dogs.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}-security-group"
  }
}

resource "aws_internet_gateway" "diamond_dogs" {
  vpc_id = aws_vpc.diamond_dogs.id

  tags = {
    Name = "${var.prefix}-internet-gateway"
  }
}

resource "aws_route_table" "diamond_dogs" {
  vpc_id = aws_vpc.diamond_dogs.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.diamond_dogs.id
  }
}

resource "aws_route_table_association" "diamond_dogs" {
  subnet_id      = aws_subnet.diamond_dogs.id
  route_table_id = aws_route_table.diamond_dogs.id
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_eip" "diamond_dogs" {
  instance = aws_instance.diamond_dogs.id
  vpc      = true
}

resource "aws_eip_association" "diamond_dogs" {
  instance_id   = aws_instance.diamond_dogs.id
  allocation_id = aws_eip.diamond_dogs.id
}

resource "aws_instance" "diamond_dogs" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.diamond_dogs.id
  vpc_security_group_ids      = [aws_security_group.diamond_dogs.id]

  user_data = templatefile("${path.module}/files/deploy_app.sh", {
    placeholder = var.placeholder
    width       = var.width
    height      = var.height
    project     = var.project
  })

  tags = {
    Name = "${var.prefix}-diamond_dogs-instance"
  }
}