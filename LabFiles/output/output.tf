provider "aws" {
  region = "us-west-1"
}

resource "aws_eip" "lb" {
  //instance = aws_instance.web.id
  domain   = "vpc"
}

output "public_ip" {
  value = aws_eip.lb
}

resource "aws_security_group" "allow_tls" {
  name        = "rg-terraform-test"
  description = "Allow TLS inbound traffic and all outbound traffic"
 
  tags = {
    Name = "allow_att_tls"
  }
}
//Cross Referencing resource attribute <resourcetype>.<name>.<attribute>
resource "aws_vpc_security_group_ingress_rule" "app_port" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = var.vpn_ip
  from_port         = 8080 # Because the range from port and to port
  ip_protocol       = "tcp"
  to_port           = 8080 # Because the range from port and to port
}
resource "aws_vpc_security_group_ingress_rule" "ssh_port" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = var.vpn_ip
  from_port         = 22 # Because the range from port and to port
  ip_protocol       = "tcp"
  to_port           = 22 # Because the range from port and to port
}
resource "aws_vpc_security_group_ingress_rule" "ftp_port" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = var.vpn_ip
  from_port         = 21 # Because the range from port and to port
  ip_protocol       = "tcp"
  to_port           = 21 # Because the range from port and to port
}