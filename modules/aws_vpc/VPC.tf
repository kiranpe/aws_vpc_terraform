//VPC
########

locals {
  vpc_tags = {
    createdby = "Kiran Peddineni"
    App       = "vpc-${terraform.workspace}"
    Approver  = "Kiran Peddineni"
  }
}

resource "aws_vpc" "vpc" {
  count = var.create_vpc ? 1 : 0

  cidr_block                       = var.cidr
  instance_tenancy                 = var.instance_tenancy
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support
  enable_classiclink               = var.enable_classiclink
  enable_classiclink_dns_support   = var.enable_classiclink_dns_support
  assign_generated_ipv6_cidr_block = var.enable_ipv6

  tags = merge(
    {
      "Name" = "${var.name}-${terraform.workspace}"
    },
    local.vpc_tags
  )
}
