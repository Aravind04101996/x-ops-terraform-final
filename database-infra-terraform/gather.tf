data "aws_availability_zones" "available" {}

data "aws_caller_identity" "current" {}

data "aws_ami" "db_agent_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name = "name"
    values = [
      "amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2",
    ]
  }
}