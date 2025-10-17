# VPC CIDR block
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Number of public subnets to create
variable "public_subnet_count" {
  description = "Number of public subnets to create"
  type        = number
  default     = 3
}

# Number of private subnets to create
variable "private_subnet_count" {
  description = "Number of private subnets to create"
  type        = number
  default     = 3
}

# AWS region (used for availability zones)
variable "region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}
