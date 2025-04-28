variable prj_name {
    type = string
    default= "hellobaghub"
}

variable prj_environment {
    type = string
    default= "production"
}

variable common_tags {
    type = map(string)
    default= {tags="team1-bag-prj"}
}

variable ec2_create {
    type = bool
    default =true
}


variable vpc_create {
    type = bool
    default =true
}

variable main_public_subnet_cidr{
    type = list(string)
    default = ["10.0.10.0/24","10.0.20.0/24"]
}

variable main_private_subnet_cidr {
    type = list(string)
    default = ["10.0.110.0/24","10.0.120.0/24"]
}

variable all_access {
    type = string
    default = "0.0.0.0/0"
}

variable ec2_mater{
    type = map(string)
    default = {
        name = "master-svr",
        ami = "ami-01938df366ac2d954",
        instance_type = "t3.medium"
    }
}

variable ec2_worker{
    type = map(string)
    default = {
        name = "worker-svr",
        ami = "ami-01938df366ac2d954",
        instance_type = "t3.medium"
    }
}

variable ec2_jumphost{
    type = map(string)
    default = {
        name = "jumphost",
        ami = "ami-01938df366ac2d954",
        instance_type = "t2.micro"
    }
}


variable "hellobag_keypair" {
  type        = string
  default = "cnfp-sg-key"
}

variable "ssh_ingress_cidrblock_all"{
    type = list(string)
    default = ["0.0.0.0/0"]
}

variable "ssh_egress_cidrblock_all"{
    type = list(string)
    default = ["0.0.0.0/0"]
}

variable "pod_network_cidr"{
    type = string
    default = "192.168.0.0/16"
}

variable "pod_network_ci2d" {
type = string
default = "172.32.0.0/16"
}


variable "vpc_cidr_block"{
    type = string
    default = "10.0.0.0/16"
}


variable "public_subnet_tags" {
type = map(string)
default = {
    "kubernetes.io/role/elb"  = 1
    "kubernetes.io/cluster/kubernetes"	= "owned"
}
description = "Tags to apply to all private subnets for lb discovery"
}

variable "private_subnet_tags" {
type = map(string)
default = {
    "kubernetes.io/role/internal_elb"  = 1
}
}

