//VARIABLES VALUES
###################

create_vpc                     = true
name                           = "vpc"
cidr                           = "10.0.0.0/26"
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
