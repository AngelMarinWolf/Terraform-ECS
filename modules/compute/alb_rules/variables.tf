variable "listener_arn" {
  type        = "string"
  description = "The ARN from the listener inside of the ALB in which will be added the routing rules."
}
variable "priority_rules" {
  type        = "string"
  description = "This is an arbitrary value in order to specify the priority of the rules in the case that you have to add multiples rule groups in the same listener."
}
variable "target_group_backend_arn" {
  type        = "string"
  description = "This variable is the target ARN in order to forward the matches at this Backend point."
}
variable "target_group_frontend_arn" {
  type        = "string"
  description = "This variable is the target ARN in order to forward the matches at this Frontend point."
}

variable "load_balancer_rules_back" {
  type = "map"
  description = "You have to specify which rules will be added in the LoadBalancer."

  default = {
    rule1      = ["www.example.com", "/wp*"]
    rule2      = ["www.example.com", "*.php"]
  }
}

variable "load_balancer_rules_front" {
  type = "map"
  description = "You have to specify which rules will be added in the LoadBalancer."

  default = {
    rule1      = ["www.example.com"]
  }
}
