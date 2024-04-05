
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc
data "aws_vpc" "selected" {
  default = true
}


# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets

data "aws_subnets" "pb-subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
  filter { #  Notes:  A load balancer cannot be attached to multiple subnets in the same Availability Zone.
    name   = "tag:Name"
    values = ["default*"]
  }
}

data "aws_route53_zone" "selected" {
  name         = var.hosted-zone
}

data "aws_ssm_parameter" "password" {
  name = "/clarusway/phonebook/password"
}

data "aws_ssm_parameter" "username" {
  name = "/clarusway/phonebook/username"
}

data "aws_ssm_parameter" "example_parameter" {
  name = "/clarusway/phonebook/token"
}