# Create Route Tables
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc_for_eks.id
  tags = {
    Name = "public_route_table"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

resource "aws_route_table" "private_route_table1" {
    vpc_id = aws_vpc.vpc_for_eks.id
    tags = {
        Name = "private_route_table"
    }
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat_gateway_1.id
    }
}

resource "aws_route_table" "private_route_table2" {
    vpc_id = aws_vpc.vpc_for_eks.id
    tags = {
        Name = "private_route_table"
    }
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat_gateway_2.id
    }
}
# Create Route Table Association
resource "aws_route_table_association" "public_route_table_association1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_route_table_association2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_route_table_association1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table1.id
}

resource "aws_route_table_association" "private_route_table_association2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table2.id
}



