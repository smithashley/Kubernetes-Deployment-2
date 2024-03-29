resource "aws_eip" "natgateway_eip_1" {
  domain   = "vpc"
}

resource "aws_eip" "natgateway_eip_2" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "nat_gateway_1" {
  allocation_id = aws_eip.natgateway_eip_1.id
  subnet_id = aws_subnet.public_subnet_1.id

  tags = {
    Name = "nat_gateway_1"
  }
  depends_on = [aws_internet_gateway.internet_gateway]
}

resource "aws_nat_gateway" "nat_gateway_2" {
  allocation_id = aws_eip.natgateway_eip_2.id
  subnet_id = aws_subnet.public_subnet_2.id

  tags = {
    Name = "nat_gateway_2"
  }
  depends_on = [aws_internet_gateway.internet_gateway]
}