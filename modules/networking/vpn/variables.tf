variable "aws_region" {
  type = "string"
  description = "Select your Amazon Region."
}

variable "project_name" {
  type          = "string"
  description   = "A logical name that will be used as prefix and tag for the created resources."
}

variable "environment" {
  description = "A logical name that will be used as prefix and tag for the created resources."
  type        = "string"
}

variable "server_ami" {
  type             = "map"
  description      = "Define a group of possibles AMIs for the VPN server."
  default = {
    us-east-1      = "ami-f6eed4e0"
    us-east-2      = "ami-6d163708"
    us-west-1      = "ami-091f3069"
    us-west-2      = "ami-e346559a"
  }
}

variable "public_key" {
  type        = "string"
  description = "Public SSH Key, this key will be used to access in the server."
}

variable "availability_zone" {
  type          = "string"
  description   = "Define the availability zone of your preference."
}

variable "subnet_id" {
  type          = "string"
  description   = "The list of all the subnets in which can be launched the RDS."
}

variable "security_groups" {
  type          = "list"
  description   = "This variable receive a list with the security groups that will be attached."
}
