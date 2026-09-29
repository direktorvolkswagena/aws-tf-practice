# VPC + IGW
resource "aws_vpc" "vpc_2" {
  cidr_block = var.vpc_cidr


  tags = {
    Name        = "vpc_2"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_2.id

  tags = {
    Name = "igw"
  }
}

# 1 Private + 1 public subnet per Availability zone

resource "aws_subnet" "private_sub_1" {
  vpc_id            = aws_vpc.vpc_2.id
  cidr_block        = var.private_subnets[0]
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "private_sub_1"
  }

}

resource "aws_subnet" "public_sub_1" {
  vpc_id                  = aws_vpc.vpc_2.id
  cidr_block              = var.public_subnets[0]
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "public_sub_1"
  }

}

resource "aws_subnet" "private_sub_2" {
  vpc_id            = aws_vpc.vpc_2.id
  cidr_block        = var.private_subnets[1]
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "private_sub_2"
  }

}

resource "aws_subnet" "public_sub_2" {
  vpc_id                  = aws_vpc.vpc_2.id
  cidr_block              = var.public_subnets[1]
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "public_sub_2"
  }

}

resource "aws_subnet" "private_sub_3" {
  vpc_id            = aws_vpc.vpc_2.id
  cidr_block        = var.private_subnets[2]
  availability_zone = var.availability_zones[2]

  tags = {
    Name = "private_sub_3"
  }

}

resource "aws_subnet" "public_sub_3" {
  vpc_id                  = aws_vpc.vpc_2.id
  cidr_block              = var.public_subnets[2]
  availability_zone       = var.availability_zones[2]
  map_public_ip_on_launch = true

  tags = {
    Name = "public_sub_3"
  }

}

# Route Table + Associations for private subnets 
# 0.0.0.0/16 -> IGW
# 10.0.0.0/16 -> local

resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.vpc_2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "rt_public"
  }
}

resource "aws_route_table_association" "rta_public_1" {
  subnet_id      = aws_subnet.public_sub_1.id
  route_table_id = aws_route_table.rt_public.id
}

resource "aws_route_table_association" "rta_public_2" {
  subnet_id      = aws_subnet.public_sub_2.id
  route_table_id = aws_route_table.rt_public.id
}

resource "aws_route_table_association" "rta_public_3" {
  subnet_id      = aws_subnet.public_sub_3.id
  route_table_id = aws_route_table.rt_public.id
}

# NATGW + Public IP 

resource "aws_eip" "eip_1" {
  tags = {
    Name = "eip_1"
  }
}

resource "aws_nat_gateway" "natgw_1" {
  allocation_id = aws_eip.eip_1.id
  subnet_id     = aws_subnet.public_sub_1.id

  tags = {
    Name = "natgw_1"
  }
}

# Route Table + Associations for private subnets 
# 0.0.0.0/16 -> NATGW
# 10.0.0.0/16 -> local

resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.vpc_2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw_1.id
  }

  tags = {
    Name = "rt_private"
  }
}

resource "aws_route_table_association" "rta_private_1" {
  subnet_id      = aws_subnet.private_sub_1.id
  route_table_id = aws_route_table.rt_private.id
}

resource "aws_route_table_association" "rta_private_2" {
  subnet_id      = aws_subnet.private_sub_2.id
  route_table_id = aws_route_table.rt_private.id
}

resource "aws_route_table_association" "rta_private_3" {
  subnet_id      = aws_subnet.private_sub_3.id
  route_table_id = aws_route_table.rt_private.id
}