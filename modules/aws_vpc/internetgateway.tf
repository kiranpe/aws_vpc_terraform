###################
# Internet Gateway
###################
locals {
  igw_tags = {
    Approver  = "Kiran Peddineni"
    CreatedBy = "Kiran Peddineni"
    App       = "${terraform.workspace}_igw"
  }
}

resource "aws_internet_gateway" "igw" {
  count = var.create_vpc && var.create_igw && length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.vpc[0].id

  tags = merge(
    {
      "Name" = "${terraform.workspace}-igw"
    },
    local.igw_tags,
  )
}
