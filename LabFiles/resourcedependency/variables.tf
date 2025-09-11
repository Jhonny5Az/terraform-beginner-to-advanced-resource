# variable "my-list" {
#   type = list
# }
# variable "my-set" {
#     type = set(string)
# }

variable "user_name" {
  type = set(string)
  default = [ "alice","bob","sofia" ]
}
variable "my-map" {
  default = {
    key = "value1"
    key1 = "value1"
  }
}