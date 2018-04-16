output "sg_alb_id" {
  description = "Returns the ID of the ELB's Security Group."
  value       = "${aws_security_group.load_balancer.id}"
}

output "sg_ec2_id" {
  description = "Returns the ID of the EC2's Security Group."
  value       = "${aws_security_group.instances.id}"
}

output "sg_rds_id" {
  description = "Returns the ID of the RDS's Security Group."
  value       = "${aws_security_group.databases.id}"
}

output "sg_vpn_id" {
  description = "Returns the ID of the VPN's Security Group."
  value       = "${aws_security_group.vpn.id}"
}
