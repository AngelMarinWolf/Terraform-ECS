############################
# Elastic IP
############################
resource "aws_eip" "vpn_ip" {
  instance = "${aws_instance.vpn.id}"
  vpc      = true
}

############################
# SSH Key
############################
resource "aws_key_pair" "public_key" {
  key_name   = "vpn-${var.project_name}-${var.environment}"
  public_key = "${var.public_key}"
}

############################
# OpenVPN Server
############################
resource "aws_instance" "vpn" {
    ami                     = "${var.server_ami[var.aws_region]}"
    instance_type           = "t2.micro"
    key_name                = "${aws_key_pair.public_key.key_name}"

    monitoring              = true
    disable_api_termination = false

    availability_zone       = "${var.availability_zone}"
    subnet_id               = "${var.subnet_id}"
    vpc_security_group_ids  = ["${var.security_groups}"]

    root_block_device {
      volume_type           = "gp2"
      volume_size           = 10
      delete_on_termination = true
    }

    tags {
      Name        = "VPN-${var.project_name}-${var.environment}"
      Environment = "${var.environment}"
      Project     = "${var.project_name}"
    }

    volume_tags {
      Name        = "VPN-${var.project_name}-${var.environment}"
      Environment = "${var.environment}"
      Project     = "${var.project_name}"
    }

}
