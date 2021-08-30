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
