provider "aws" {
  region = "us-west-1"
}

resource "aws_eip" "lb" {
  //instance = aws_instance.web.id
  domain   = "vpc"
}

resource "aws_security_group" "allow_tls" {
  name        = "rg-terraform-att"
  description = "Allow TLS inbound traffic and all outbound traffic"
  //vpc_id      = aws_vpc.main.id

  tags = {
    Name = "allow_att_tls"
  }
}
//Cross Referencing resource attribute <resourcetype>.<name>.<attribute>
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "${aws_eip.lb.public_ip}/32"
  from_port         = 80 # Because the range from port and to port
  ip_protocol       = "tcp"
  to_port           = 120 # Because the range from port and to port
}


/* 
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

//Cross Referencing resource attribute <resourcetype>.<name>.<attribute>
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "Web attrib EC2-02"
  }
}
 */