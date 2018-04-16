variable "project_name" {
  type          = "string"
  description   = "A logical name that will be used as prefix and tag for the created resources."
}
variable "environment" {
  type          = "string"
  description   = "A logical name that will be used as prefix and tag for the created resources."
}
variable "subnet_ids" {
  type          = "list"
  description   = "The list of all the subnets in which can be launched the RDS."
}
variable "engine" {
  type          = "string"
  description   = "Select the engine for the Database [mysql, aurora-mysql]."
  default       = "mysql"
}
variable "engine_family" {
  type           = "map"
  description    = "If you want to use a custom family for the Database Engines, set a map for the options."
  default = {
    mysql        = "mysql5.7"
    aurora-mysql = "aurora-mysql5.7"
  }
}
variable "storage" {
  description   = "This variable define the Storage allocated for the RDS instance."
  default       = 10
}
variable "instance_tier" {
  type          = "string"
  description   = "This variable define the type of instance that will be launched."
  default       = "db.t2.micro"
}
variable "db_username" {
  type          = "string"
  description   = "Master username for the RDS instance."
  default       = "root"
}
variable "db_password" {
  type          = "string"
  description   = "Master password for the RDS instance."
}
variable "vpc_security_group_ids" {
  type          = "list"
  description   = "This variable receive a list with the security groups that will be attached."
}
variable "apply_immediately" {
  description   = "Define the method to be used on for the changes [immediately could cause downtime for several minutes]."
  default       = false
}
variable "multi_az" {
  description   = "Multi-AZ option could include extra charges."
  default       = false
}
variable "availability_zone" {
  type          = "string"
  description   = "Define the availability zone of your preference."
}
variable "final_snapshot" {
  description = "Option for skip the final final_snapshot."
  default = false
}
variable "retention" {
  description   = "Define the number of days for Backup retention."
  default       = 5
}
