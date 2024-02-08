# Create 2 Private Subnets
resource "aws_subnet" "private_subnet_1" {
    vpc_id = aws_vpc.vpc_for_eks.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "private_subnet_1"
        "kubernetes.io/role/internal-elb" = 1
    }
}

resource "aws_subnet" "private_subnet_2" {
    vpc_id = aws_vpc.vpc_for_eks.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    tags = {
        Name = "private_subnet_2"
        "kubernetes.io/role/internal-elb" = 1
    }
}

# Create 2 Public Subnets
resource "aws_subnet" "public_subnet_1" {
    vpc_id = aws_vpc.vpc_for_eks.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "public_subnet_1"
        "kubernetes.io/role/elb" = 1
    }
}

resource "aws_subnet" "public_subnet_2" {
    vpc_id = aws_vpc.vpc_for_eks.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "us-east-1b"
    tags = {
        Name = "public_subnet_2"
        "kubernetes.io/role/elb" = 1
    }
}

output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
}
output "public_subnet_2_id" {
  value = aws_subnet.public_subnet_2.id
}
output "private_subnet_1_id" {
  value = aws_subnet.private_subnet_1.id
}
output "private_subnet_2_id" {
  value = aws_subnet.private_subnet_2.id
}