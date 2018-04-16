############################
# ERC Repositories
############################
resource "aws_ecr_repository" "be-repository" {
  name = "be-${var.project_name}"
}

resource "aws_ecr_repository" "fe-repository" {
  name = "fe-${var.project_name}"
}

############################
# ECS Cluster
############################
resource "aws_ecs_cluster" "cluster" {
  name = "ecs-${var.project_name}-${var.environment}"
}
