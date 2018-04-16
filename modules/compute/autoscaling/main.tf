##################################################
# Create an IAM role to allow ECS activity
##################################################
resource "aws_iam_role" "ecs_instance_role" {
  name = "ecs_instance_role_${var.project_name}_${var.environment}"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["ec2.amazonaws.com"]
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "ecs" {
  name = "ecs_instance_role_${var.project_name}_${var.environment}"
  path = "/"
  role = "${aws_iam_role.ecs_instance_role.name}"
}

resource "aws_iam_role_policy_attachment" "ecs_ec2_role" {
  role       = "${aws_iam_role.ecs_instance_role.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ecs_ec2_cloudwatch_role" {
  role       = "${aws_iam_role.ecs_instance_role.id}"
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

############################
# SSH Key
############################
resource "aws_key_pair" "public_key" {
  key_name   = "ecs-${var.project_name}-${var.environment}"
  public_key = "${var.public_key}"
}

############################
# Launch Configuration
############################
resource "aws_launch_configuration" "lc_ecs" {
  name                    = "lc-ecs-${var.project_name}-${var.environment}"

  key_name                = "${aws_key_pair.public_key.key_name}"
  image_id                = "${var.server_ami[var.aws_region]}"
  instance_type           = "${var.instance_type}"
  iam_instance_profile    = "${aws_iam_instance_profile.ecs.id}"
  associate_public_ip_address = true
  
  security_groups         = ["${var.security_groups}"]
  user_data               = "${var.user_data}"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 40
    delete_on_termination = true
  }

}

############################
# Placement Group
############################
resource "aws_placement_group" "pg_ecs" {
  name                      = "pg-ecs-${var.project_name}-${var.environment}"
  strategy                  = "spread"
}

############################
# AutoScailing Group
############################
resource "aws_autoscaling_group" "autoscaling" {
  depends_on                = ["aws_launch_configuration.lc_ecs"]
  availability_zones        = ["${var.availability_zones}"]
  name                      = "autoscaling-${var.project_name}-${var.environment}"

  desired_capacity          = "${var.desired_capacity}"
  max_size                  = "${var.max_size}"
  min_size                  = "${var.min_size}"

  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  placement_group           = "${aws_placement_group.pg_ecs.id}"
  launch_configuration      = "${aws_launch_configuration.lc_ecs.name}"

  vpc_zone_identifier       = ["${var.subnet_ids}"]
  enabled_metrics           = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]

  tags = [
    {
      key                     = "Name"
      value                   = "autoscaling-${var.project_name}-${var.environment}"
      propagate_at_launch     = true
    },
    {
      key                     = "Environment"
      value                   = "${var.environment}"
      propagate_at_launch     = true
    },
    {
      key                     = "Project"
      value                   = "${var.project_name}"
      propagate_at_launch     = true
    }
  ]
}
