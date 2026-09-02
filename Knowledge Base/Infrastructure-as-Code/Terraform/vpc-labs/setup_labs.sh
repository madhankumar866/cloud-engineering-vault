#!/bin/bash
BASE_DIR="/Users/mk/Documents/01_Active_Work/obsidian/Cloud-Engineering-Vault/Knowledge Base/Infrastructure-as-Code/Terraform/vpc-labs"

# Lab 2
mkdir -p "$BASE_DIR/lab-2"
cat << 'HCL' > "$BASE_DIR/lab-2/providers.tf"
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                      = "ap-south-1"
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    ec2 = "http://localhost:4566"
  }
}
HCL

cp "$BASE_DIR/lab-1/variables.tf" "$BASE_DIR/lab-2/variables.tf"

cat << 'HCL' > "$BASE_DIR/lab-2/main.tf"
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "lab2-vpc" }
}

resource "aws_subnet" "public" {
  for_each = var.public_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true
  tags = { Name = "lab2-public-${each.value.az}" }
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  tags = { Name = "lab2-private-${each.value.az}" }
}

# --- LAB 2 NEW RESOURCES ---
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = { Name = "lab2-igw" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "lab2-public-rt" }
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}
HCL

cat << 'HCL' > "$BASE_DIR/lab-2/outputs.tf"
output "vpc_id" { value = aws_vpc.main.id }
output "public_subnet_ids" { value = [for subnet in aws_subnet.public : subnet.id] }
output "private_subnet_ids" { value = [for subnet in aws_subnet.private : subnet.id] }
output "igw_id" { value = aws_internet_gateway.igw.id }
output "public_rt_id" { value = aws_route_table.public.id }
HCL

# Lab 3
mkdir -p "$BASE_DIR/lab-3"
cp "$BASE_DIR/lab-2/providers.tf" "$BASE_DIR/lab-3/providers.tf"
cp "$BASE_DIR/lab-2/variables.tf" "$BASE_DIR/lab-3/variables.tf"

cat << 'HCL' > "$BASE_DIR/lab-3/main.tf"
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "lab3-vpc" }
}

resource "aws_subnet" "public" {
  for_each = var.public_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true
  tags = { Name = "lab3-public-${each.value.az}" }
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  tags = { Name = "lab3-private-${each.value.az}" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = { Name = "lab3-igw" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "lab3-public-rt" }
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# --- LAB 3 NEW RESOURCES ---
resource "aws_eip" "nat" {
  for_each = aws_subnet.public
  domain   = "vpc"
  tags = { Name = "lab3-eip-${each.value.availability_zone}" }
}

resource "aws_nat_gateway" "nat" {
  for_each = aws_subnet.public
  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = each.value.id
  tags = { Name = "lab3-nat-${each.value.availability_zone}" }
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private" {
  for_each = aws_subnet.private
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[each.key].id
  }
  tags = { Name = "lab3-private-rt-${each.value.availability_zone}" }
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}
HCL

cp "$BASE_DIR/lab-2/outputs.tf" "$BASE_DIR/lab-3/outputs.tf"
cat << 'HCL' >> "$BASE_DIR/lab-3/outputs.tf"
output "nat_gateway_ids" { value = [for nat in aws_nat_gateway.nat : nat.id] }
HCL


# Lab 4
mkdir -p "$BASE_DIR/lab-4"
cp "$BASE_DIR/lab-3/providers.tf" "$BASE_DIR/lab-4/providers.tf"
cp "$BASE_DIR/lab-3/variables.tf" "$BASE_DIR/lab-4/variables.tf"

cat << 'HCL' > "$BASE_DIR/lab-4/main.tf"
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "lab4-vpc" }
}

resource "aws_subnet" "public" {
  for_each = var.public_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true
  tags = { Name = "lab4-public-${each.value.az}" }
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  tags = { Name = "lab4-private-${each.value.az}" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = { Name = "lab4-igw" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "lab4-public-rt" }
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
  for_each = aws_subnet.public
  domain   = "vpc"
  tags = { Name = "lab4-eip-${each.value.availability_zone}" }
}

resource "aws_nat_gateway" "nat" {
  for_each = aws_subnet.public
  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = each.value.id
  tags = { Name = "lab4-nat-${each.value.availability_zone}" }
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private" {
  for_each = aws_subnet.private
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[each.key].id
  }
  tags = { Name = "lab4-private-rt-${each.value.availability_zone}" }
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}

# --- LAB 4 NEW RESOURCES ---
resource "aws_security_group" "web_sg" {
  name        = "lab4-web-sg"
  description = "Allow HTTP and SSH inbound"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "lab4-web-sg" }
}

resource "aws_network_acl" "public_nacl" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = [for s in aws_subnet.public : s.id]

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 130
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  egress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  egress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  tags = { Name = "lab4-public-nacl" }
}
HCL

cp "$BASE_DIR/lab-3/outputs.tf" "$BASE_DIR/lab-4/outputs.tf"
cat << 'HCL' >> "$BASE_DIR/lab-4/outputs.tf"
output "web_sg_id" { value = aws_security_group.web_sg.id }
output "public_nacl_id" { value = aws_network_acl.public_nacl.id }
HCL

chmod +x setup_labs.sh
./setup_labs.sh
rm setup_labs.sh
