variable "project_name" {
  type          = "string"
  description   = "A logical name that will be used as prefix and tag for the created resources."
}

variable "environment" {
  type        = "string"
  description = "A logical name that will be used as prefix and tag for the created resources."
}

variable "aws_region" {
  type = "string"
  description = "Describe the Amazon region in which you will work."
  default = "us-west-2"
}

variable "server_ami" {
  type             = "map"
  description      = "It is a map with a list of AMIs used for each region, minimum is Required one for you region."

  default = {
    us-east-1      = "ami-cad827b7"
    us-east-2      = "ami-ef64528a"
    us-west-1      = "ami-29b8b249"
    us-west-2      = "ami-baa236c2"
  }
}

variable "subnet_ids" {
  type          = "list"
  description   = "The list of all the subnets in which can be launched the New EC2 Instances."
}

variable "security_groups" {
  type          = "list"
  description   = "This variable receive a list with the security groups that will be attached."
}

variable "user_data" {
  type          = "string"
  description   = "This variable receive the user-data script that will be executed at the launch time."
}

variable "desired_capacity" {
  type          = "string"
  description   = "The number of instances to start the Autoscaling."
}

variable "max_size" {
  type          = "string"
  description   = "The max number of instances to scale the Autoscaling."
}

variable "min_size" {
  type          = "string"
  description   = "The min number of instances to scale the Autoscaling."
}

variable "instance_type" {
  type          = "string"
  description   = "Define the tier level or class of the EC2 Instances."
}

variable "availability_zones" {
  type          = "list"
  description   = "Define the availability zone of your preference."
}

variable "public_key" {
  type        = "string"
  description = "Public SSH Key, this key will be used to access in the server."
}
