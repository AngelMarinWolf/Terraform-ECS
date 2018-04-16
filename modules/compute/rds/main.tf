##################################################
# Create an IAM role to allow enhanced monitoring
##################################################
resource "aws_iam_role" "rds_enhanced_monitoring" {
  name               = "rds-monitoring-role-${var.project_name}-${var.environment}"
  assume_role_policy = "${data.aws_iam_policy_document.rds_enhanced_monitoring.json}"
}

resource "aws_iam_role_policy_attachment" "rds_enhanced_monitoring" {
  role       = "${aws_iam_role.rds_enhanced_monitoring.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

data "aws_iam_policy_document" "rds_enhanced_monitoring" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "policy" {
  name          = "enhanced-monitoring-attachment-${var.project_name}-${var.environment}"
  role          = "${aws_iam_role.rds_enhanced_monitoring.name}"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "EnableCreationAndManagementOfRDSCloudwatchLogGroups",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:PutRetentionPolicy"
            ],
            "Resource": [
                "arn:aws:logs:*:*:log-group:RDS*"
            ]
        },
        {
            "Sid": "EnableCreationAndManagementOfRDSCloudwatchLogStreams",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:DescribeLogStreams",
                "logs:GetLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:*:*:log-group:RDS*:log-stream:*"
            ]
        }
    ]
}
EOF
}

#######################
# Subnet Group
#######################
resource "aws_db_subnet_group" "subnet_group" {
  name          = "subnet-group-${var.project_name}-${var.environment}"
  subnet_ids    = ["${var.subnet_ids}"]

  tags = {
    Name        = "subnet-group-${var.environment}"
    Environment = "${var.environment}"
    Project     = "${var.project_name}"
  }
}

#######################
# Parameter Group
#######################
resource "aws_db_parameter_group" "parameter_group" {
  name        = "parameter-group-${var.project_name}-${var.environment}"
  description = "Parameter Group defined for ${var.project_name}-${var.environment}"

  family      = "${var.engine_family[var.engine]}"

  tags = {
    Name        = "subnet-group-${var.environment}"
    Environment = "${var.environment}"
    Project     = "${var.project_name}"
  }

}

#######################
# RDS Instance
#######################
resource "aws_db_instance" "instance" {
  allocated_storage       = "${var.storage}"
  storage_type            = "gp2"

  engine                  = "${var.engine}"
  engine_version          = "${var.engine == "mysql" ? "5.7.17" : "2.01.1"}"
  instance_class          = "${var.instance_tier}"

  identifier              = "rds-${var.project_name}-${var.environment}"

  username                = "${var.db_username}" # Master username
  password                = "${var.db_password}"

  db_subnet_group_name    = "${aws_db_subnet_group.subnet_group.id}"
  parameter_group_name    = "${aws_db_parameter_group.parameter_group.id}"
  vpc_security_group_ids  = ["${var.vpc_security_group_ids}"]

  publicly_accessible     = false
  apply_immediately       = "${var.apply_immediately}"

  multi_az                = "${var.multi_az}"
  availability_zone       = "${var.availability_zone}"

  backup_retention_period = "${var.retention}"
  backup_window           = "01:00-02:00"

  final_snapshot_identifier = "final-rds-${var.project_name}-${var.environment}"
  skip_final_snapshot     = "${var.final_snapshot}"

  maintenance_window      = "Fri:02:15-Fri:03:15"
  monitoring_role_arn     = "${aws_iam_role.rds_enhanced_monitoring.arn}"
  monitoring_interval     = "10"

  tags = {
    Name        = "rds-${var.project_name}-${var.environment}"
    Environment = "${var.environment}"
    Project     = "${var.project_name}"
  }
}
