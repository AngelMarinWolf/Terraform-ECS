variable "vpc_id" {
  type        = "string"
  description = "Define in which VPC will be created the SG."
}

variable "project_name" {
  type          = "string"
  description   = "A logical name that will be used as prefix and tag for the created resources."
}

variable "environment" {
  type        = "string"
  description = "A logical name that will be used as prefix and tag for the created resources."
}

variable "public_ip" {
  type        = "list"
  description = "The IPs of your Office."
}
