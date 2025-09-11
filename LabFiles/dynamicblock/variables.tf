variable "sg_ports" {
  type        = list(number)
  description = "list of ingress port"
  default     = [8200, 8201, 83, 9200, 9500]
}

variable "iam_name" {
  type =  list
  default = ["user-00","user-01","user-02","user-03","user-04"]  
}