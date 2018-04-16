############################
# ALB Listeners Rules
############################
resource "aws_lb_listener_rule" "backend" {
  count             = "${length(keys(var.load_balancer_rules_back))}"
  listener_arn      = "${var.listener_arn}"
  priority          = "${var.priority_rules+count.index}"

  action {
    type             = "forward"
    target_group_arn = "${var.target_group_backend_arn}"
  }

  condition {
    field  = "host-header"
    values = ["${element(var.load_balancer_rules_back[element(keys(var.load_balancer_rules_back),count.index)],0)}"]
  }

  condition {
    field  = "path-pattern"
    values = ["${element(var.load_balancer_rules_back[element(keys(var.load_balancer_rules_back),count.index)],1)}"]
  }

}

resource "aws_lb_listener_rule" "frontend" {
  count             = "${length(keys(var.load_balancer_rules_front))}"
  listener_arn      = "${var.listener_arn}"
  priority          = "${var.priority_rules+50+count.index}"

  action {
    type             = "forward"
    target_group_arn = "${var.target_group_frontend_arn}"
  }

  condition {
    field  = "host-header"
    values = ["${element(var.load_balancer_rules_front[element(keys(var.load_balancer_rules_front),count.index)],0)}"]
  }
}
