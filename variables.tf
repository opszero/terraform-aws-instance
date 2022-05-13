
variable "bastion_name" {}
variable "ssh_key" {
  description = "SSH public key to add to the image"
  default     = ""
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

variable "ec2_connect_installed" {
  default = true
}

variable "user_data" {
  default = ""
}

variable "users" {
  default     = []
  description = "List of IAM users to attach ssh IAM policy"
}
