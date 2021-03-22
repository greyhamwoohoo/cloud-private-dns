#
# Public Subnet with an Internet Gateway
#
resource "aws_subnet" "testytesty_public_subnet" {
  vpc_id                  = aws_vpc.testytesty_vpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = "true"
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.testytesty_vpc.id

  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.testytesty_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

resource "aws_route_table_association" "public_root_table_assocation" {
  subnet_id      = aws_subnet.testytesty_public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

#
# Public Subnet with a NAT Gateway
#
resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.testytesty_public_subnet.id
  depends_on    = [aws_internet_gateway.internet_gateway]
}

#
# Private subnet that access the Internet via the NAT Gateway in the Public Subnet
#
resource "aws_subnet" "testytesty_private_subnet" {
  vpc_id     = aws_vpc.testytesty_vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.testytesty_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
}

resource "aws_route_table_association" "private_route_table_association" {
  subnet_id      = aws_subnet.testytesty_private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}
