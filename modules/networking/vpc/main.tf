############################
# Amazon VPC
############################
resource "aws_vpc" "vpc" {
  cidr_block  = "${var.vpc_cidr}"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "vpc-${var.environment}"
    Environment = "${var.environment}"
    Project     = "${var.project_name}"
  }
}

############################
# Create Public Subnets
############################
resource "aws_subnet" "public_subnet" {
  count                   = "${length(var.availability_zones[var.aws_region])}"

  vpc_id                  = "${aws_vpc.vpc.id}"

  cidr_block              = "${cidrsubnet(var.vpc_cidr,8,count.index)}"
  availability_zone       = "${element(var.availability_zones[var.aws_region], count.index)}"
  map_public_ip_on_launch = false

  tags {
    Name = "public-${element(var.availability_zones[var.aws_region], count.index)}-${var.environment}"
    Environment = "${var.environment}"
    Project     = "${var.project_name}"
  }
}

############################
# Create Private Subnets
############################
resource "aws_subnet" "private_subnet" {
  count                   = "${length(var.availability_zones[var.aws_region])}"

  vpc_id                  = "${aws_vpc.vpc.id}"

  cidr_block              = "${cidrsubnet(var.vpc_cidr,8,count.index + 100)}"
  availability_zone       = "${element(var.availability_zones[var.aws_region], count.index)}"
  map_public_ip_on_launch = false

  tags {
    Name = "private-${element(var.availability_zones[var.aws_region], count.index)}-${var.environment}"
    Environment = "${var.environment}"
    Project     = "${var.project_name}"
  }
}

############################
# Internet Gateway
############################
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name        = "internet-gateway-${var.environment}"
    Environment = "${var.environment}"
    Project     = "${var.project_name}"
  }
}

############################
# NAT Gateway
############################
resource "aws_eip" "nat_ip" {
  count         = "${length(var.availability_zones[var.aws_region])}"
  vpc           = true
}

resource "aws_nat_gateway" "nat" {
  count         = "${length(var.availability_zones[var.aws_region])}"

  allocation_id = "${element(aws_eip.nat_ip.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public_subnet.*.id, count.index)}"

  tags {
    Name        = "nat-gateway-${var.environment}-${element(var.availability_zones[var.aws_region], count.index)}"
    Environment = "${var.environment}"
    Project     = "${var.project_name}"
  }
}

############################
# Public Table Route
############################
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.internet_gateway.id}"
  }

  tags {
    Name        = "public-routetable-${var.environment}"
    Environment = "${var.environment}"
    Project     = "${var.project_name}"
  }
}

############################
# Private Table Route
############################
resource "aws_route_table" "private" {
  count          = "${length(var.availability_zones[var.aws_region])}"
  vpc_id         = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.nat.id}"
  }

  tags {
    Name        = "private-routetable-${var.environment}-${element(var.availability_zones[var.aws_region], count.index)}"
    Environment = "${var.environment}"
    Project     = "${var.project_name}"
  }
}

############################
# Public Routing
############################
resource "aws_route_table_association" "public_routing_table" {
  count          = "${length(var.availability_zones[var.aws_region])}"

  subnet_id      = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

############################
# Private Routing
############################
resource "aws_route_table_association" "private_routing_table" {
  count          = "${length(var.availability_zones[var.aws_region])}"

  subnet_id      = "${element(aws_subnet.private_subnet.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}
