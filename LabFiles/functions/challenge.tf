provider "aws" {
  region = "us-west-1"
}

resource "local_file" "name" {
  content  = "sss"
  filename = "${path.module}/logs.txt"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_ami" "AmazonVmdAmi" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "app-dev" {
  //ami = lookup(var.ami,var.region)
  //ami = data.aws_ami.ubuntu.id
  ami           = data.aws_ami.AmazonVmdAmi.id
  instance_type = "t2.micro"
  count         = length(var.tags)

  tags = {
    Name         = element(var.tags, count.index)
    CreationDate = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
  }
}

/* data "aws_instance" "ec2Instance" {
   filter {
    name   = "tag:Name"
    values = ["secondec2"]
  }
} */

output "name" {
  value = "${element(var.tags, 0)} <---> ${formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())}"
}

/* output "nameAwsInstance" {
  value = data.aws_instances.ec2Instance.
} */

resource "aws_security_group" "sg_01" {
  name = "app_firewall"
  tags = var.tagss
}

resource "aws_security_group" "sg_02" {
  name = "db_firewall"
  tags = local.default
}