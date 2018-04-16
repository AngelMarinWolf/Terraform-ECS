output "vpc_id" {
  description = "The id of the VPC."
  value       = "${aws_vpc.vpc.id}"
}

output "vpc_cidr" {
  description = "The CDIR block used for the VPC."
  value       = "${aws_vpc.vpc.cidr_block}"
}

output "public_subnets" {
  description = "A list of the public subnets."
  value       = ["${aws_subnet.public_subnet.*.id}"]
}

output "private_subnets" {
  description = "A list of the private subnets."
  value       = ["${aws_subnet.private_subnet.*.id}"]
}

output "public_routing_table_id" {
  description = "The id of the public routing table."
  value       = "${aws_route_table.public.id}"
}

output "private_routing_table_id" {
  description = "A list of the private routing tables."
  value       = ["${aws_route_table.private.*.id}"]
}

output "availability_zones" {
  description = "List of the availability zones."
  value       = ["${var.availability_zones[var.aws_region]}"]
}
