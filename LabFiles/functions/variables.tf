variable "region" {
  default = "us-east-1"
}

variable "tags" {
  type    = list(any)
  default = ["firstec2", "secondec2"]
}

variable "tagss" {
  type = map(any)
  default = {
    Team = "security-team"
  }
}

//local can apply values dynamically
locals {
  default = {
    Team         = "security-team-local"
    CreationDate = "date-${formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())}"
  }
}

variable "ami" {
  type = map(any)
  default = {
    "us-east-1"  = "ami-08a0d1e16fc3f61ea"
    "us-west-2"  = "ami-0b20a6f09484773af"
    "ap-south-1" = "ami-0e1d06225679bc1c5"
  }
}