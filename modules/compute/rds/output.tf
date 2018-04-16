output "subnet_group_id" {
  description = "Get the ID of for the Subnet Group."
  value       = "${aws_db_subnet_group.subnet_group.id}"
}

output "parameter_group_id" {
  description = "Get the ID of for the Parameter Group."
  value       = "${aws_db_parameter_group.parameter_group.id}"
}

output "subnet_group_arn" {
  description = "Get the ARN of for the Subnet Group."
  value       = "${aws_db_subnet_group.subnet_group.arn}"
}

output "parameter_group_arn" {
  description = "Get the ARN of for the Parameter Group."
  value       = "${aws_db_parameter_group.parameter_group.arn}"
}

output "instance_id" {
  description = "Get the ID of for the RDS instance."
  value       = "${aws_db_instance.instance.id}"
}

output "endpoint" {
  description = "Get the Endpoint of for the RDS instance."
  value       = "${aws_db_instance.instance.endpoint}"
}

output "status" {
  description = "Get the Status of for the RDS instance."
  value       = "${aws_db_instance.instance.status}"
}
