variable "ami_id" {
  default     = null
  type        = string
  description = "The AMI ID of the bastion host"
}

variable "name" {
  description = "The name of the bastion host"
  type        = string
}

variable "ssh_keys" {
  description = "SSH public keys to add to the image"
  default     = []
  type        = list(any)
}

variable "tags" {
  default     = {}
  description = "A map of tags to assign to the resource"
  type        = map(any)
}

variable "vpc_id" {
  description = "The VPC ID to create security group for bastion host"
  type        = string
}

variable "subnet_id" {
  description = "The VPC subnet ID to launch in EC2 bastion host"
  type        = string
}

variable "security_group_ids" {
  default     = []
  description = "A list of security group names to associate with."
  type        = list(any)
}

variable "userdata" {
  default     = ""
  description = "User data to provide when launching the instance"
  type        = string
}

variable "volume_size" {
  default     = 20
  description = "Size of the volume in gibibytes (GiB)"
  type        = number

}

variable "instance_type" {
  default     = "t3.micro"
  description = "EC2 Instance Type of the bastion host"
  type        = string
}

variable "ingress_cidrs" {
  description = "Configuration block for ingress rules"
}

variable "user_data" {
  default     = ""
  description = "User data to provide when launching the instance"
  type        = string
}

variable "user_data_replace_on_change" {
  default     = false
  description = "To recreate the instance when user_data is changed"
  type        = bool
}

variable "users" {
  description = "Custom user accounts of the instance"
  default = {
    "retool" = {
      ssh-keys = []
    }
  }
}

variable "efs_mounts" {
  description = "EFS multiple mounts"
  default     = {}
  #"fs-09f8c986f1367012a" = {
  #  mount_path = "/tmp/efs1"
  #},
  #"fs-0314bf3a3f8c0e652" = {
  #  mount_path = "/tmp/efs2"
  #}
  #}
}
