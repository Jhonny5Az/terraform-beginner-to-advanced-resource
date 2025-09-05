provider "aws" {
  region = "us-west-1"
}

/* resource "aws_iam_user" "lb" {
  name = var.username
} */


output "variable_value" {
  value = [var.username, var.variableMap]
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

//Cross Referencing resource attribute <resourcetype>.<name>.<attribute>
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.environment == "development" ? "t2.micro" : "m5.large"
  //Count meta-argument
  count = 3

  tags = {
    Name = "Web attrib EC2-${count.index}"
  }
}

output "name_ec2_intances" {
  value = aws_instance.web[1].tags.Name
}

resource "aws_iam_user" "name" {
  //name= "payment_user${count.index}"
  name = var.username[count.index]
  count = 4
}
output "name" {
  value = aws_iam_user.name
}