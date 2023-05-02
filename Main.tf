# Defined a map variable called "vpc_list" that contains two key-value pairs, where the key is the name of the environment ("prod" and "dev") and the value is another map that contains the VPC configuration for each environment.
locals {
  vpc_list = {
    "prod" = {
      vpc_id = "prod-net11"
      vpc_cidr = "10.0.0.0/16"
      azs = ["us-east-1a", "us-east-1b"]
      vpc_public_subnets  = ["10.0.1.0/24"]
      vpc_private_subnets = ["10.0.2.0/24"]
      vpc_enable_nat_gateway = true
      vpc_enable_vpn_gateway = false
      vpc_tags = {
        Name = "prod"
        Terraform = "true"
        Environment = "prod"
        Facing = "private"
      }
    },

    "dev" = {
      vpc_id = "dev-net13"
      vpc_cidr = "10.13.0.0/16"
      azs = ["us-east-1a", "us-east-1b"]
      vpc_public_subnets  = ["10.13.5.0/24"]
      vpc_private_subnets = ["10.13.1.0/24"]
      vpc_enable_nat_gateway = false
      vpc_enable_vpn_gateway = false
      vpc_tags = {
        Name = "dev"
        Terraform = "true"
        Environment = "dev"
        Facing = "private"
      }
    },
  }
}

# Created an EC2 VPC module using the Terraform AWS VPC module from the Terraform registry. The for_each loop is used to create an instance of the module for each environment defined in the "vpc_list" variable.
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"
  for_each = local.vpc_list # Use `for_each` to create a separate VPC for each entry
  name = each.key # Set the VPC name as the key of the current `for_each` iteration
  cidr = each.value.vpc_cidr # Set the VPC CIDR block as the `vpc_cidr` value of the current `for_each` iteration
  azs = each.value.azs # Set the availability zones as the `azs` value of the current `for_each` iteration
  public_subnets  = each.value.vpc_public_subnets # Set the public subnets as the `vpc_public_subnets` value of the current `for_each` iteration
  private_subnets = each.value.vpc_private_subnets # Set the private subnets as the `vpc_private_subnets` value of the current `for_each` iteration
  enable_nat_gateway = each.value.vpc_enable_nat_gateway # Set whether or not to enable NAT gateway as the `vpc_enable_nat_gateway` value of the current `for_each` iteration
  enable_vpn_gateway = each.value.vpc_enable_vpn_gateway # Set whether or not to enable VPN gateway as the `vpc_enable_vpn_gateway` value of the current `for_each` iteration
  tags = each.value.vpc_tags # Set tags as the `vpc_tags` value of the current `for_each` iteration
}
