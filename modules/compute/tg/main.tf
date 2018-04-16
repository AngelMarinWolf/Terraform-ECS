############################
# Target Groups
############################
resource "aws_lb_target_group" "target_group_backend" {
  name                  = "tg-be-${var.project_name}-${var.environment}"
  port                  = 80
  protocol              = "HTTP"
  vpc_id                = "${var.vpc_id}"
  deregistration_delay  = 60

  health_check {
    interval            = 10
    path                = "/wp-json/"
    protocol            = "HTTP"
    matcher             = "301"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }

  stickiness {
    type              = "lb_cookie"
    cookie_duration   = "86400" # 1 day
    enabled           = true
  }
}

resource "aws_lb_target_group" "target_group_frontend" {
  name                  = "tg-fe-${var.project_name}-${var.environment}"
  port                  = 80
  protocol              = "HTTP"
  vpc_id                = "${var.vpc_id}"
  deregistration_delay  = 60

  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    matcher             = "301"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }
}
