variable "project_name" {
  type          = "string"
  description   = "A logical name that will be used as prefix and tag for the created resources."
}

variable "environment" {
  type        = "string"
  description = "A logical name that will be used as prefix and tag for the created resources."
}
variable "public_subnets" {
  type          = "list"
  description   = "The list of all the subnets in wich can be launched the RDS."
}
variable "security_groups" {
  type          = "list"
  description   = "This variable receive a list with the security groups that will be attached."
}

variable "vpc_id" {
  type        = "string"
  description = "Define in which VPC will be created the SG."
}

variable "target_group_frontend_arn" {
  type        = "string"
  description = "Define the default target group to send traffic."
}

variable "ssl_certificate_arn" {
  type        = "string"
  description = "If you add this variable another linstener will be created using the protocol HTTPS with this certificate."
  default     = ""
}
