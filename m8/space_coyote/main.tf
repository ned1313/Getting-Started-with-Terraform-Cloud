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
      Billable = var.billable
    }
  }
}

module "networking" {
  source        = "./networking"
  region        = var.region
  prefix        = var.prefix
  environment   = var.environment
  address_space = "10.0.0.0/16"
  subnet_prefix = "10.0.10.0/24"
}

module "s3_bucket" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  bucket_prefix = "${var.prefix}-${var.environment}"
  acl           = "private"

  versioning = {
    enabled = true
  }

}

resource "aws_security_group" "space_coyote" {
  name = "${var.prefix}-security-group"

  vpc_id = module.networking.vpc_id

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

resource "aws_eip" "space_coyote" {
  instance = aws_instance.space_coyote.id
  vpc      = true
}

resource "aws_eip_association" "space_coyote" {
  instance_id   = aws_instance.space_coyote.id
  allocation_id = aws_eip.space_coyote.id
}

resource "aws_instance" "space_coyote" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = module.networking.subnet_id
  vpc_security_group_ids      = [aws_security_group.space_coyote.id]

  user_data = templatefile("${path.module}/files/deploy_app.sh", {})

  tags = {
    Name = "${var.prefix}-space_coyote-instance"
  }
}