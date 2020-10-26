//Main VPC File
################
module "vpc" {
  source = "./modules/aws_vpc"

  //VARIABLES VALUES
  ###################

  create_vpc                     = true
  name                           = "vpc"
  cidr                           = "10.0.0.0/22"
  instance_tenancy               = "default"
  enable_dns_hostnames           = true
  enable_dns_support             = true
  enable_classiclink             = null
  enable_classiclink_dns_support = null
  enable_ipv6                    = false

  //SECURITY GROUP
  #####################

  sec_grp_name = "vpc"

  default_security_group_ingress = [
    {
      from_port   = 22
      to_port     = 22
      cidr_blocks = "0.0.0.0/0"
      protocol    = "tcp"
      description = "VPC Prod Security Group"
    },
    {
      from_port   = 0
      to_port     = 65535
      cidr_blocks = "0.0.0.0/0"
      protocol    = "tcp"
      description = "VPC Prod Security Group"
    },
  ]

  default_security_group_egress = [
    {
      from_port   = 0
      to_port     = 0
      cidr_blocks = "0.0.0.0/0"
      description = "VPC Prod Security Group"
    }
  ]

  //Availability Zones
  #####################

  azs = ["us-east-2a", "us-east-2b", "us-east-2c"]

  //Public Subnet
  ###################

  public_subnet_suffix    = "public"
  public_subnets          = ["10.0.0.0/26", "10.0.0.64/26"]
  map_public_ip_on_launch = true

  //Private Subnet
  ##################

  private_subnet_suffix = "private"
  private_subnets       = ["10.0.0.128/26", "10.0.0.192/26"]

  //IGW
  ########

  create_igw = true

  single_nat_gateway = false

}
