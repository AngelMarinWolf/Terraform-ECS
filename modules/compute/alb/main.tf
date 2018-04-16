############################
# Application Load Balancer
############################
resource "aws_lb" "application_load_balancer" {
  name            = "alb-${var.project_name}-${var.environment}"
  internal        = false
  security_groups = ["${var.security_groups}"]
  subnets         = ["${var.public_subnets}"]

  enable_http2 = true

  tags {
    Name        = "alb-${var.project_name}-${var.environment}"
    Environment = "${var.environment}"
    Project     = "${var.project_name}"
  }
}

############################
# ALB Listeners
############################
resource "aws_lb_listener" "default" {
  load_balancer_arn = "${aws_lb.application_load_balancer.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${var.target_group_frontend_arn}"
    type             = "forward"
  }
}

resource "aws_lb_listener" "ssl" {
  count             = "${var.ssl_certificate_arn == "" ? 0 : 1}"
  load_balancer_arn = "${aws_lb.application_load_balancer.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = "${var.ssl_certificate_arn}"

  default_action {
    target_group_arn = "${var.target_group_frontend_arn}"
    type             = "forward"
  }
}
