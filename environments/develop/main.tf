############################
# Configure the AWS Provider
############################
provider "aws" {
  access_key    = "${var.aws_access_key}"
  secret_key    = "${var.aws_secret_key}"
  region        = "${var.aws_region}"
}

############################
# Init VPC Module
############################
module "vpc" {
  source              = "../../modules/networking/vpc"

  aws_region          = "${var.aws_region}"
  vpc_cidr            = "${var.vpc_cidr}"
  project_name        = "${var.project_name}"
  environment         = "${var.environment}"
  availability_zones  = "${var.availability_zones}"
}

############################
# Init Security Groups Module
############################

module "security_groups" {
  source              = "../../modules/networking/security_group"

  vpc_id              = "${module.vpc.vpc_id}"
  environment         = "${var.environment}"
  project_name        = "${var.project_name}"
  public_ip           = ["${var.public_ip}"]
}

############################
# Init S3 Module
############################
module "s3-develop-1" {
  source              = "../../modules/compute/s3"

  environment         = "${var.environment}"
  project_name        = "${var.project_name}-1"
}

module "s3-develop-2" {
  source              = "../../modules/compute/s3"

  environment         = "${var.environment}"
  project_name        = "${var.project_name}-2"
}

module "s3-staging" {
  source              = "../../modules/compute/s3"

  environment         = "staging"
  project_name        = "${var.project_name}"
}

resource "aws_s3_bucket" "private_bucket" {
  bucket = "templates-${var.project_name}"
  acl    = "private"

  tags {
    Environment = "${var.environment}"
    Project     = "${var.project_name}"
  }
}

############################
# Init VPN Module
############################
module "vpn" {
  source                   = "../../modules/networking/vpn"

  aws_region               = "${var.aws_region}"
  availability_zone        = "${element(module.vpc.availability_zones, 0)}"
  subnet_id                = "${element(module.vpc.public_subnets, 0)}"
  security_groups          = ["${module.security_groups.sg_vpn_id}"]

  environment              = "${var.environment}"
  project_name             = "${var.project_name}"

  public_key               = "${file("./templates/keys/vpn-server.pub")}"

}

############################
# Init RDS Module
############################
module "rds" {
  source                 = "../../modules/compute/rds"

  project_name           = "${var.project_name}"
  environment            = "${var.environment}"

  engine                 = "${var.engine}"
  storage                = "${var.storage}"
  instance_tier          = "${var.instance_tier}"

  db_username            = "${var.db_username}"
  db_password            = "${var.db_password}"

  subnet_ids             = "${module.vpc.private_subnets}"
  availability_zone      = "${element(module.vpc.availability_zones, 0)}"
  vpc_security_group_ids = ["${module.security_groups.sg_rds_id}"]

  apply_immediately      = "${var.apply_immediately}"
  multi_az               = "${var.multi_az}"
  retention              = "${var.retention}"
  final_snapshot         = "${var.final_snapshot}"
}

############################
# Init ALB Module
############################
module "alb" {
  source                   = "../../modules/compute/alb"

  vpc_id                   = "${module.vpc.vpc_id}"
  public_subnets           = "${module.vpc.public_subnets}"
  security_groups          = ["${module.security_groups.sg_alb_id}"]

  ssl_certificate_arn       = "${var.ssl_certificate_arn}"
  target_group_frontend_arn = "${module.tg_develop_1.alb_tg_fe_arn}"

  environment              = "${var.environment}"
  project_name             = "${var.project_name}"

}

############################
# Init Target Groups Modules
############################
module "tg_develop_1" {
  source                   = "../../modules/compute/tg"

  vpc_id                   = "${module.vpc.vpc_id}"

  environment              = "${var.environment}-1"
  project_name             = "${var.project_name}"
}

module "tg_develop_2" {
  source                   = "../../modules/compute/tg"

  vpc_id                   = "${module.vpc.vpc_id}"

  environment              = "${var.environment}-2"
  project_name             = "${var.project_name}"
}

module "tg_staging" {
  source                   = "../../modules/compute/tg"

  vpc_id                   = "${module.vpc.vpc_id}"

  environment              = "staging"
  project_name             = "${var.project_name}"
}

############################
# Init ALB Rules Modules
############################
module "alb_rules_develop_1" {
  source                    = "../../modules/compute/alb_rules"

  listener_arn              = "${module.alb.alb_listener_arn}"
  priority_rules            = 100
  target_group_backend_arn  = "${module.tg_develop_1.alb_tg_be_arn}"
  target_group_frontend_arn = "${module.tg_develop_1.alb_tg_fe_arn}"
  load_balancer_rules_back  = "${var.load_balancer_rules_back_dev_1}"
  load_balancer_rules_front = "${var.load_balancer_rules_front_dev_1}"
}

module "alb_rules_develop_2" {
  source                   = "../../modules/compute/alb_rules"

  listener_arn              = "${module.alb.alb_listener_arn}"
  priority_rules            = 200
  target_group_backend_arn  = "${module.tg_develop_2.alb_tg_be_arn}"
  target_group_frontend_arn = "${module.tg_develop_2.alb_tg_fe_arn}"
  load_balancer_rules_back  = "${var.load_balancer_rules_back_dev_2}"
  load_balancer_rules_front = "${var.load_balancer_rules_front_dev_2}"
}

module "alb_rules_staging" {
  source                    = "../../modules/compute/alb_rules"

  listener_arn              = "${module.alb.alb_listener_arn}"
  priority_rules            = 300
  target_group_backend_arn  = "${module.tg_staging.alb_tg_be_arn}"
  target_group_frontend_arn = "${module.tg_staging.alb_tg_fe_arn}"
  load_balancer_rules_back  = "${var.load_balancer_rules_back_stage}"
  load_balancer_rules_front = "${var.load_balancer_rules_front_stage}"
}

module "alb_rules_develop_1_ssl" {
  source                    = "../../modules/compute/alb_rules"

  listener_arn              = "${element(module.alb.alb_listener_ssl_arn,0)}"
  priority_rules            = 100
  target_group_backend_arn  = "${module.tg_develop_1.alb_tg_be_arn}"
  target_group_frontend_arn = "${module.tg_develop_1.alb_tg_fe_arn}"
  load_balancer_rules_back  = "${var.load_balancer_rules_back_dev_1}"
  load_balancer_rules_front = "${var.load_balancer_rules_front_dev_1}"
}

module "alb_rules_develop_2_ssl" {
  source                   = "../../modules/compute/alb_rules"

  listener_arn              = "${element(module.alb.alb_listener_ssl_arn,0)}"
  priority_rules            = 200
  target_group_backend_arn  = "${module.tg_develop_2.alb_tg_be_arn}"
  target_group_frontend_arn = "${module.tg_develop_2.alb_tg_fe_arn}"
  load_balancer_rules_back  = "${var.load_balancer_rules_back_dev_2}"
  load_balancer_rules_front = "${var.load_balancer_rules_front_dev_2}"
}

module "alb_rules_staging_ssl" {
  source                    = "../../modules/compute/alb_rules"

  listener_arn              = "${element(module.alb.alb_listener_ssl_arn,0)}"
  priority_rules            = 300
  target_group_backend_arn  = "${module.tg_staging.alb_tg_be_arn}"
  target_group_frontend_arn = "${module.tg_staging.alb_tg_fe_arn}"
  load_balancer_rules_back  = "${var.load_balancer_rules_back_stage}"
  load_balancer_rules_front = "${var.load_balancer_rules_front_stage}"
}
############################
# Init ecs Module
############################
module "ecs" {
  source                   = "../../modules/compute/ecs"

  environment              = "${var.environment}"
  project_name             = "${var.project_name}"

}

############################
# Init AutoScaling Module
############################
module "autoscaling" {
  source                   = "../../modules/compute/autoscaling"

  environment              = "${var.environment}"
  project_name             = "${var.project_name}"
  aws_region               = "${var.aws_region}"

  subnet_ids               = ["${module.vpc.public_subnets}"]
  security_groups          = ["${module.security_groups.sg_ec2_id}"]
  availability_zones       = ["${module.vpc.availability_zones}"]

  desired_capacity         = "${var.desired_capacity}"
  max_size                 = "${var.max_size}"
  min_size                 = "${var.min_size}"
  instance_type            = "${var.instance_type}"

  public_key               = "${file("./templates/keys/ecs-server.pub")}"
  user_data                = "${file("./templates/user-data.sh")}"

}
