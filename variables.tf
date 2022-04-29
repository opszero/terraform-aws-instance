variable "bastion_name" {}
variable "ssh_keys" {
  description = "SSH Keys to add to the image"
  default     = []
}
variable "tags" {
  default = {}
}
variable "vpc_id" {}
variable "subnet_id" {}
variable "security_group_ids" {
  default = []
}
variable "ubuntu_version" {
  default = "20.04"
}

variable "userdata" {
  default = ""
}
variable "volume_size" {
  default = 20
}

variable "instance_type" {
  default = "t3.micro"
}

variable "ingress_cidrs" {}
