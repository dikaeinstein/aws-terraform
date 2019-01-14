variable "access_key" {}
variable "secret_key" {}

variable "region" {
  default = "eu-west-2"
}

variable "amis" {
  type = "map"
  default = {
    "eu-west-2" = "ami-061a2d878e5754b62"
  }
}
