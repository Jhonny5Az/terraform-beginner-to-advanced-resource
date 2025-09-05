variable "username" {
  //type = number
  //type = list(number)
    type = list
    default = ["t1","t2","sss","sda"]
}

variable "variableMap" {
    type = map
    default = {
        Name ="Alias"
        Team = "DefaultT"
    }
}

variable "environment" {
  default = "development"
}