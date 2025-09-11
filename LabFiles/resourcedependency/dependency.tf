data "aws_ami" "AmazonVmdAmi" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  owners = ["amazon"]
}

/* resource "aws_instance" "app-dev" {
  //ami = lookup(var.ami,var.region)
  //ami = data.aws_ami.ubuntu.id
  ami = data.aws_ami.AmazonVmdAmi.id
  //ami = "ami-015eb52029f53ced2"
  instance_type = "t3.micro"
  vpc_security_group_ids = [ aws_security_group.awssg.id ]

  tags = {
    Name         = "test1Earth"
    CreationDate = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
  }
  depends_on = [ aws_s3_bucket.bucketexample ]

  //MetaArguments
  lifecycle {
    ignore_changes = [tags]
    create_before_destroy = true
  }
} 

resource "aws_s3_bucket" "bucketexample" {
  bucket = "kp-demo-s3001"
}

resource "aws_security_group" "awssg" {
    name = "production-sg" 
} */

resource "aws_iam_user" "lb" {
  for_each = var.user_name
  name = each.value
}