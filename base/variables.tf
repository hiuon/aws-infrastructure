variable "aws_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["a", "b", "c"]
}

variable "cidr_blocks_public" {
  description = "List of cidr blockes for public subnets"
  type        = list(string)
  default     = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
}

variable "cidr_blocks_private" {
  description = "List of cidr blockes for private subnets"
  type        = list(string)
  default     = ["10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24"]
}

variable "cidr_blocks_private_db" {
  description = "List of cidr blockes for private subnets with db"
  type        = list(string)
  default     = ["10.10.20.0/24", "10.10.21.0/24", "10.10.22.0/24"]
}