//NAT Gateway
##############

locals {
  nat_gateway_ips = split(
    ",",
    var.reuse_nat_ips ? join(",", var.external_nat_ip_ids) : join(",", aws_eip.nat.*.id),
  )

  nat_gateway_tags = {
    Approver  = "Kiran Peddineni"
    CreatedBy = "Kiran Peddineni"
    App       = "${terraform.workspace}-natgw"
  }
}

resource "aws_eip" "nat" {
  #  count = var.create_vpc && var.enable_nat_gateway && false == var.reuse_nat_ips ? 1 : 0

  count = var.create_vpc ? 1 : 0

  vpc = true

  tags = merge(
    {
      "Name" = format(
        "%s-%s",
        var.name,
        element(var.azs, var.single_nat_gateway ? 0 : count.index),
      )
    },
    local.nat_gateway_tags,
  )
}

resource "aws_nat_gateway" "natgw" {
  #  count = var.create_vpc && var.enable_nat_gateway ? 1 : 0

  count = var.create_vpc ? 1 : 0

  allocation_id = element(
    local.nat_gateway_ips,
    var.single_nat_gateway ? 0 : count.index,
  )
  subnet_id = element(
    aws_subnet.public.*.id,
    var.single_nat_gateway ? 0 : count.index,
  )

  tags = merge(
    {
      "Name" = format(
        "%s-%s",
        var.name,
        element(var.azs, var.single_nat_gateway ? 0 : count.index),
      )
    },
    local.nat_gateway_tags,
  )

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route" "private_nat_gateway" {
  #  count = var.create_vpc && var.enable_nat_gateway ? 1 : 0

  count = var.create_vpc ? 1 : 0

  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.natgw.*.id, count.index)

  timeouts {
    create = "5m"
  }
}

//Route table association
##########################

resource "aws_route_table_association" "private" {
  count = var.create_vpc && length(var.private_subnets) > 0 ? length(var.private_subnets) : 0

  subnet_id = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(
    aws_route_table.private.*.id,
    var.single_nat_gateway ? 0 : count.index,
  )
}

resource "aws_route_table_association" "public" {
  count = var.create_vpc && length(var.public_subnets) > 0 ? length(var.public_subnets) : 0

  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public[0].id
}
