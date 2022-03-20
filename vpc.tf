## VPC
resource "aws_vpc" "demo" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "demo"
  }
}

## Subnet
resource "aws_subnet" "public-a" {
  vpc_id            = aws_vpc.demo.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "demo-public-1a"
  }
}

resource "aws_subnet" "public-c" {
  vpc_id            = aws_vpc.demo.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "demo-public-1c"
  }
}

resource "aws_subnet" "private-a" {
  vpc_id            = aws_vpc.demo.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "demo-private-1a"
  }
}

resource "aws_subnet" "private-c" {
  vpc_id            = aws_vpc.demo.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "demo-private-1c"
  }
}

resource "aws_internet_gateway" "demo" {
  vpc_id = aws_vpc.demo.id

  tags = {
    Name = "demo-igw"
  }
}

## RouteTable
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.demo.id

  tags = {
    Name = "demo-public-rtb"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.demo.id

  tags = {
    Name = "demo-private-rtb"
  }
}

## Route
resource "aws_route" "public" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.demo.id
}

resource "aws_route" "private" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.private.id
  gateway_id             = aws_internet_gateway.demo.id
}

## TableAssociation
resource "aws_route_table_association" "public-a" {
  subnet_id      = aws_subnet.public-a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-c" {
  subnet_id      = aws_subnet.public-c.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private-a" {
  subnet_id      = aws_subnet.private-a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private-c" {
  subnet_id      = aws_subnet.private-c.id
  route_table_id = aws_route_table.private.id
}