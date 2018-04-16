output "alb_id" {
  description = "Returns the ID from the Application Load Balancer."
  value       = "${aws_lb.application_load_balancer.id}"
}
output "alb_arn" {
  description = "Returns the ARN from the Application Load Balancer."
  value       = "${aws_lb.application_load_balancer.arn}"
}
output "alb_listener_id" {
  description = "Returns the ID from the HTTP listener attached in the ALB."
  value       = "${aws_lb_listener.default.id}"
}
output "alb_listener_arn" {
  description = "Returns the ARN from the HTTP listener attached in the ALB."
  value       = "${aws_lb_listener.default.arn}"
}
output "alb_listener_ssl_id" {
  description = "Returns the ID from the HTTPS listener attached in the ALB. (optional)"
  value       = "${aws_lb_listener.ssl.*.id}"
}
output "alb_listener_ssl_arn" {
  description = "Returns the ARN from the HTTPS listener attached in the ALB. (optional)"
  value       = "${aws_lb_listener.ssl.*.arn}"
}
