variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Map of public subnets"
  type = map(object({
    cidr = string
    az   = string
  }))
  default = {
    "1" = { cidr = "10.0.1.0/24", az = "ap-south-1a" }
    "2" = { cidr = "10.0.2.0/24", az = "ap-south-1b" }
  }
}

variable "private_subnets" {
  description = "Map of private subnets"
  type = map(object({
    cidr = string
    az   = string
  }))
  default = {
    "1" = { cidr = "10.0.3.0/24", az = "ap-south-1a" }
    "2" = { cidr = "10.0.4.0/24", az = "ap-south-1b" }
  }
}
