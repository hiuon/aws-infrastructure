resource "aws_vpc" "main" {
  provider = aws.use1

  cidr_block = "10.10.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    "Name"      = "cloudx-vpc"
    "Terraform" = "true"
    "Project"   = "cloudx"
  }
}

resource "aws_subnet" "public" {
  provider                = aws.use1
  count                   = length(var.cidr_blocks_public)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.cidr_blocks_public[count.index]
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1${var.aws_zones[count.index]}"
  tags = {
    "Name"      = "cloudx-subnet-${var.aws_zones[count.index]}"
    "Terraform" = "true"
    "Project"   = "cloudx"
  }
}