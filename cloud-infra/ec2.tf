resource "aws_s3_bucket" "s3_hbh" {
  bucket = "${var.prj_name}s3"

  tags = {
    Name        = "${var.prj_name}s3"
    Environment = var.prj_environment
  }
}

data "aws_ami" "ubuntu" {
  count = var.vpc_create && var.ec2_create ? 1 : 0
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_ami" "amazon-ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["amazon"]
}






resource "aws_instance" "master" {
  count       = var.ec2_create && var.vpc_create ? 1 : 0 
  ami           = data.aws_ami.amazon-ami.id
  instance_type = var.ec2_mater.instance_type
  subnet_id = aws_subnet.private[0].id
  key_name = var.hellobag_keypair
  vpc_security_group_ids = [aws_security_group.sg-k8s[0].id]
  associate_public_ip_address = false
  iam_instance_profile = aws_iam_instance_profile.demo-k8s-aws-alb-iam-profile.name
  user_data = templatefile("templates/master.sh", {
    bucket_name = aws_s3_bucket.s3_hbh.bucket
  }) 
  root_block_device {
    volume_size = 15        # Size in GiB
    volume_type = "gp3"       # Volume type (SSD)
    delete_on_termination = true  # Delete when instance terminates
  }

  tags = merge(
    { Name = "${var.prj_name}-master-ec2"},
      var.common_tags
  )

  depends_on = [ aws_eip.nat_eip ,aws_nat_gateway.ngw,aws_s3_bucket.s3_hbh,aws_iam_instance_profile.demo-k8s-aws-alb-iam-profile]

  }

resource "aws_instance" "worker" {
  count       = var.ec2_create && var.vpc_create ? length(var.main_private_subnet_cidr) : 0 
  ami           = data.aws_ami.amazon-ami.id
  instance_type = var.ec2_worker.instance_type
  subnet_id = aws_subnet.private[count.index].id
  key_name = var.hellobag_keypair
  vpc_security_group_ids = [aws_security_group.sg-k8s[0].id]
  iam_instance_profile =aws_iam_instance_profile.demo-k8s-aws-alb-iam-profile.name
  associate_public_ip_address = false
  user_data = templatefile("templates/worker.sh", 
  {
    bucket_name = aws_s3_bucket.s3_hbh.bucket,
    worker_number = count.index + 1
 })
  
  root_block_device {
    volume_size = 15      # Size in GiB
    volume_type = "gp3"       # Volume type (SSD)
    delete_on_termination = true  # Delete when instance terminates
  }
  
  tags = merge(
    { Name = "${var.prj_name}-worker-ec2"},
      var.common_tags
  )

  depends_on = [ aws_eip.nat_eip ,aws_nat_gateway.ngw,aws_instance.master,aws_s3_bucket.s3_hbh ,aws_iam_instance_profile.admin_instance_profile]
}

resource "aws_instance" "jumphost" {
  count       = var.ec2_create && var.vpc_create ? 1 : 0 
  ami           = data.aws_ami.amazon-ami.id
  instance_type = var.ec2_jumphost.instance_type
  subnet_id = aws_subnet.public[0].id
  key_name = var.hellobag_keypair
  vpc_security_group_ids = [aws_security_group.sg_jumphost[0].id]
  associate_public_ip_address = true
  iam_instance_profile =aws_iam_instance_profile.demo-k8s-aws-alb-iam-profile.name
  user_data = templatefile("templates/jumphost.sh", 
  {
    bucket_name = aws_s3_bucket.s3_hbh.bucket,
  })
  tags = merge(
    { Name = "${var.prj_name}-jumphost-ec2"},
      var.common_tags
  )
depends_on = [ aws_instance.master,aws_s3_bucket.s3_hbh,aws_iam_instance_profile.demo-k8s-aws-alb-iam-profile]

}