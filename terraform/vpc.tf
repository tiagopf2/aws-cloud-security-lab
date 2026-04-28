# -----------------------------------------------
# PRIMARY VPC (Linux Instance)
# -----------------------------------------------
resource "aws_vpc" "primary" {
  cidr_block           = "172.31.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "primaryVPC-Tiago"
  }
}

resource "aws_subnet" "primary_public" {
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = "172.31.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "primary-public-subnet"
  }
}

resource "aws_internet_gateway" "primary_igw" {
  vpc_id = aws_vpc.primary.id

  tags = {
    Name = "primary-igw"
  }
}

resource "aws_route_table" "primary_rt" {
  vpc_id = aws_vpc.primary.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.primary_igw.id
  }

  # Route to secondary VPC via peering
  route {
    cidr_block                = "10.0.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  }

  tags = {
    Name = "primary-route-table"
  }
}

resource "aws_route_table_association" "primary_rta" {
  subnet_id      = aws_subnet.primary_public.id
  route_table_id = aws_route_table.primary_rt.id
}

# -----------------------------------------------
# SECONDARY VPC (Linux 2 — Private, No Public IP)
# -----------------------------------------------
resource "aws_vpc" "secondary" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "secondaryVPC-tiago"
  }
}

resource "aws_subnet" "secondary_private" {
  vpc_id                  = aws_vpc.secondary.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "secondary-private-subnet"
  }
}

resource "aws_route_table" "secondary_rt" {
  vpc_id = aws_vpc.secondary.id

  # Route back to primary VPC via peering
  route {
    cidr_block                = "172.31.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  }

  tags = {
    Name = "secondary-route-table"
  }
}

resource "aws_route_table_association" "secondary_rta" {
  subnet_id      = aws_subnet.secondary_private.id
  route_table_id = aws_route_table.secondary_rt.id
}

# -----------------------------------------------
# VPC PEERING CONNECTION
# -----------------------------------------------
resource "aws_vpc_peering_connection" "peer" {
  vpc_id      = aws_vpc.primary.id
  peer_vpc_id = aws_vpc.secondary.id
  auto_accept = true

  tags = {
    Name = "linux1andlinux2"
  }
}
