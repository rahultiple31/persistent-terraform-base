terraform {
  required_version = ">= 0.12.15"
}

locals {
  len_public_subnets  = length(var.public_subnets_cidr)
  len_private_subnets = length(var.private_subnets_cidr)
}

########
# VPC #
########
resource "aws_vpc" "main" {
  count                = var.create_vpc ? 1 : 0
  cidr_block           = var.network_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(
    { "Name" = var.name },
    var.vpc_tags,
    var.tags
  )
}

########
# Default Security Group #
########
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main[0].id

  ingress {
    protocol  = "-1"
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    { "Name" = "default-${var.name}" },
    var.tags
  )
}

########
# Public Subnets #
########
resource "aws_subnet" "public" {
  count                   = local.len_public_subnets
  vpc_id                  = aws_vpc.main[0].id
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = element(var.zones, count.index)
  map_public_ip_on_launch = true

  tags = merge(
    { "Name" = "${var.environment}-${element(var.zones, count.index)}-public" },
    var.public_subnet_tags,
    var.tags
  )
}

########
# Private Subnets #
########
resource "aws_subnet" "private" {
  count                   = local.len_private_subnets
  vpc_id                  = aws_vpc.main[0].id
  cidr_block              = element(var.private_subnets_cidr, count.index)
  availability_zone       = element(var.zones, count.index)
  map_public_ip_on_launch = var.associate_public_ip

  tags = merge(
    { "Name" = "${var.environment}-${element(var.zones, count.index)}-private" },
    var.private_subnet_tags,
    var.tags
  )
}

########
# Internet Gateway #
########
resource "aws_internet_gateway" "igw" {
  count  = var.create_internet_gateway ? 1 : 0
  vpc_id = aws_vpc.main[0].id

  tags = merge(
    { "Name" = "${var.name}-igw" },
    var.tags
  )
}

########
# NAT Gateway #
########
resource "aws_eip" "nat" {
  count = var.enable_nat_gateway ? local.len_public_subnets : 0
  vpc   = true

  tags = merge(
    { "Name" = "${var.environment}-${element(var.zones, count.index)}-eip" },
    var.tags
  )
}

resource "aws_nat_gateway" "nat_gw" {
  count         = var.enable_nat_gateway ? local.len_public_subnets : 0
  allocation_id = element(aws_eip.nat[*].id, count.index)
  subnet_id     = element(aws_subnet.public[*].id, count.index)

  tags = merge(
    { "Name" = "${var.environment}-${element(var.zones, count.index)}-nat" },
    var.tags
  )

  depends_on = [aws_internet_gateway.igw]
}
