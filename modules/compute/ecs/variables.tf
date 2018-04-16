variable "project_name" {
  type          = "string"
  description   = "A logical name that will be used as prefix and tag for the created resources."
}

variable "environment" {
  description = "A logical name that will be used as prefix and tag for the created resources."
  type        = "string"
}
