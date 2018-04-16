variable "aws_region" {
  description = "Select your Amazon Region."
  default = "us-west-2"
}

variable "vpc_cidr" {
  description = "The CDIR block used for the VPC."
  default     = "10.0.0.0/16"
}

variable "project_name" {
  type          = "string"
  description   = "A logical name that will be used as prefix and tag for the created resources."
}

variable "environment" {
  description = "A logical name that will be used as prefix and tag for the created resources."
  type        = "string"
}

variable "availability_zones" {
  type = "map"
  description = "Define which and how many zones will be launched."

  default = {
    us-east-1      = ["us-east-1a", "us-east-1b"]
    us-east-2      = ["us-east-2a", "eu-east-2b"]
    us-west-1      = ["us-west-1a", "us-west-1c"]
    us-west-2      = ["us-west-2a", "us-west-2b"]
    ca-central-1   = ["ca-central-1a", "ca-central-1b"]
    eu-west-1      = ["eu-west-1a", "eu-west-1b"]
    eu-west-2      = ["eu-west-2a", "eu-west-2b"]
    eu-central-1   = ["eu-central-1a", "eu-central-1b"]
    ap-south-1     = ["ap-south-1a", "ap-south-1b"]
    sa-east-1      = ["sa-east-1a", "sa-east-1c"]
    ap-northeast-1 = ["ap-northeast-1a", "ap-northeast-1c"]
    ap-southeast-1 = ["ap-southeast-1a", "ap-southeast-1b"]
    ap-southeast-2 = ["ap-southeast-2a", "ap-southeast-2b"]
    ap-northeast-1 = ["ap-northeast-1a", "ap-northeast-1c"]
    ap-northeast-2 = ["ap-northeast-2a", "ap-northeast-2c"]
  }
}
