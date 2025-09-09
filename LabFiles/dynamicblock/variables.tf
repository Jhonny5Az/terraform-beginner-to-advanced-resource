variable "sg_ports" {
  type        = list(number)
  description = "list of ingress port"
  default     = [8200, 8201, 83, 9200, 9500]
}