
resource "aws_eip" "name" {
  domain = "vpc"
}

resource "aws_security_group" "sg_main" {
  name = "attribute-sg"
}

resource "aws_vpc_security_group_ingress_rule" "example" {
  security_group_id = aws_security_group.sg_main.id

  cidr_ipv4   = "${aws_eip.name.public_ip}/32"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}
resource "aws_vpc_security_group_ingress_rule" "webingress" {
  security_group_id = aws_security_group.sg_main.id

  cidr_ipv4   = "${aws_eip.name.public_ip}/32"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}
/* resource "aws_security_group" "dynamicsg" {
  name        = "dynamic-sg"
  description = "Ingress for Vault"
  ingress {
    from_port   = 8200
    to_port     = 8200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    } */

/*   dynamic "ingress" {
    for_each = var.sg_ports
    iterator = port
    content {
      from_port = port.value
      to_port   = port.value
      from_port   = ingress.value
      to_port     = ingress.value
    #   protocol    = "tcp"
    #   cidr_blocks = ["0.0.0.0/0"]
    }
  } */
/* 
  dynamic "egress" {
    for_each = var.sg_ports
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }


} */

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
  //ami = data.aws_ami.AmazonVmdAmi.id
  ami = "ami-015eb52029f53ced2"
  instance_type = "t3.micro"

  tags = {
    Name         = "test1Earth"
    CreationDate = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
  }

  //MetaArguments
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_iam_user" "lb" {
  name  = "iamuser.${count.index}"
  count = 3
  path  = "/sytem/"
}

//Splat(*)
output "arns" {
  value = aws_iam_user.lb[*].arn
}
output "name" {
  value = aws_iam_user.lb[*].name
}

output "combine" {
  value = zipmap(aws_iam_user.lb[*].name,aws_iam_user.lb[*].arn)
}