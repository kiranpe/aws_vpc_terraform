module "vpc" {
  source = "git::https://github.com/kiranpe/aws_vpc_terraform.git?ref=v1.0"
}

provider "aws" {
  region  = "us-east-2"
  profile = "Terrafrm"
}
