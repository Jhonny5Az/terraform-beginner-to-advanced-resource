provider "aws" {
  region = "us-west-1"
}


resource "aws_iam_user" "demouser" {
    name = "demo-user"
}