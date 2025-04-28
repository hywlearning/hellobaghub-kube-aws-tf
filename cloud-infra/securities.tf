# JUMPHOST
resource "aws_security_group" "sg_jumphost" {
  count = var.ec2_create && var.vpc_create ? 1 : 0 
  name   = "Jumhost security group"
  vpc_id = aws_vpc.main[0].id

  # Allow SSH from Jump Host
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = var.ssh_ingress_cidrblock_all
  }

  # Allow all internal traffic within VPC
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self = true
  }
  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.ssh_egress_cidrblock_all
  }

}

# Security Group for Kubernetes Cluster (private instances)
resource "aws_security_group" "sg-k8s" {
  count = var.ec2_create && var.vpc_create ? 1 : 0 
  name   = "K8S Ports"
  vpc_id = aws_vpc.main[0].id

  # Allow SSH from Jump Host
  /*
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_jumphost[0].id]
  }

  ingress {
    from_port       = 6443
    to_port         = 6443
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_jumphost[0].id]
  }
 /*
  # Allow all internal traffic within VPC
  /*
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }
  */

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.sg_jumphost[0].id]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self = true
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
