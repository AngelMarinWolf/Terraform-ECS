output "autoscaling_id" {
  description = "Returns the ID of the Auto Scaling Group created."
  value       = "${aws_autoscaling_group.autoscaling.id}"
}

output "autoscaling_arn" {
  description = "Returns the ARN of the Auto Scaling Group created."
  value       = "${aws_autoscaling_group.autoscaling.arn}"
}

output "autoscaling_name" {
  description = "Returns the Name of the Auto Scaling Group created."
  value       = "${aws_autoscaling_group.autoscaling.name}"
}

output "autoscaling_lc" {
  description = "Returns the Name of the Launch Configuration used to configure the Autoscaling Group."
  value       = "${aws_autoscaling_group.autoscaling.launch_configuration}"
}

output "autoscaling_lbs" {
  description = "Returns a List with the IDs of the Load Balancers assigned for the Autoscaling Group."
  value       = "${aws_autoscaling_group.autoscaling.load_balancers}"
}

output "launch_configuration_id" {
  description = "Returns the ID of the Launch Configuration created."
  value       = "${aws_launch_configuration.lc_ecs.id}"
}

output "launch_configuration_name" {
  description = "Returns the ID of the Launch Configuration created."
  value       = "${aws_launch_configuration.lc_ecs.name}"
}
