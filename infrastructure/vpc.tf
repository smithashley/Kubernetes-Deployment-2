# Create a VPC
resource "aws_vpc" "vpc_for_eks" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "vpc_for_eks"
    }
}

output "vpc_id" {
  value = aws_vpc.vpc_for_eks.id
}
