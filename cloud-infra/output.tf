output "infra_info" {
  value     = [
    {
    vpc=aws_vpc.main[0].id,
    ec2_jumphost_publicip= var.ec2_create? aws_instance.jumphost[0].public_ip : "",
    ec2-jumphost= var.ec2_create? aws_instance.jumphost[0].private_ip : "",
    ec2-master= var.ec2_create ? aws_instance.master[0].private_ip:"",
    ec2-worker= var.ec2_create ? aws_instance.worker[0].private_ip:"",
    ec2-worker2= var.ec2_create ? aws_instance.worker[1].private_ip:""
    }]
}
