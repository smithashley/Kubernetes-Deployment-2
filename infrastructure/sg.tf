# Create VPC Security Groups
resource "aws_security_group" "eks_cluster" {
  name        = "eks-cluster-sg"
  description = "Security group for EKS cluster nodes"
  vpc_id      = aws_vpc.vpc_for_eks.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    self        = true 
  }

  ingress {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    self        = true 
  }
}