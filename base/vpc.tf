resource "aws_vpc" "main" {
  provider = aws.use1

  cidr_block = "10.10.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    "Name"      = "cloudx"
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
    "Name"      = "public_${var.aws_zones[count.index]}"
    "Terraform" = "true"
    "Project"   = "cloudx"
  }
}

resource "aws_subnet" "private" {
  provider                = aws.use1
  count                   = length(var.cidr_blocks_private)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.cidr_blocks_private[count.index]
  availability_zone       = "us-east-1${var.aws_zones[count.index]}"
  tags = {
    "Name"      = "private_${var.aws_zones[count.index]}"
    "Terraform" = "true"
    "Project"   = "cloudx"
  }
}

resource "aws_subnet" "private_db" {
  provider                = aws.use1
  count                   = length(var.cidr_blocks_private_db)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.cidr_blocks_private_db[count.index]
  availability_zone       = "us-east-1${var.aws_zones[count.index]}"
  tags = {
    "Name"      = "private_db_${var.aws_zones[count.index]}"
    "Terraform" = "true"
    "Project"   = "cloudx"
  }
}

resource "aws_internet_gateway" "this" {
  provider = aws.use1
  vpc_id = aws_vpc.main.id
  tags = {
    "Name"      = "cloudx-igw"
    "Terraform" = "true"
    "Project"   = "cloudx"
  }
}

resource "aws_route_table" "public_subnets" {
  provider = aws.use1
  vpc_id = aws_vpc.main.id

   tags = {
    "Name"      = "public_rt"
    "Terraform" = "true"
    "Project"   = "cloudx"
  }
}

resource "aws_route" "default_gateway" {
  provider = aws.use1
  route_table_id         = aws_route_table.public_subnets.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public_rt" {
  provider = aws.use1
  count = length(aws_subnet.public)
  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_subnets.id
}

resource "aws_route_table" "private_subnets" {
  provider = aws.use1
  vpc_id = aws_vpc.main.id

   tags = {
    "Name"      = "private_rt"
    "Terraform" = "true"
    "Project"   = "cloudx"
  }
}

resource "aws_route_table_association" "private_rt" {
  provider = aws.use1
  count = length(aws_subnet.private)
  subnet_id = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_subnets.id
}
