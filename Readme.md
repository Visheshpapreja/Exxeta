## Terraform AWS VPC Module
This Terraform module creates an Amazon Web Services (AWS) Virtual Private Cloud (VPC) along with the necessary networking components. It uses the terraform-aws-modules/vpc/aws module from the Terraform Registry.

## Requirements
I have used Terraform latest version 1.4.6.
AWS account with appropriate credentials.

## Assumptions
The Terraform code assumes the following:

1. AWS provider credentials have been set up and configured.
2. Two VPCs will be created, one for production and one for development environments.
3. The production VPC has a VPC ID of "prod-net11" and the development VPC has a VPC ID of "dev-net13".
4. Both VPCs have the same availability zones: "us-east-1a" and "us-east-1b".
5. The production VPC has one public subnet with a CIDR block of "10.0.1.0/24" and one private subnet with a CIDR block of "10.0.2.0/24". 
6. It also has a NAT gateway enabled and no VPN gateway.
7. The development VPC has one public subnet with a CIDR block of "10.13.5.0/24" and one private subnet with a CIDR block of "10.13.1.0/24". 
8. As per you convenience NAT or VPN gateway enabled.

## Usage
To use this Terraform module, follow these steps:

1. Clone this repository or create a new directory for your Terraform code.
2. Copy the contents of the code block above to a new file called main.tf.
3. In the local block of the main.tf file, update the VPC IDs, CIDR blocks, availability zones, and other properties as needed for your specific use case.
4. Run terraform init to initialize the working directory.
5. Run terraform plan to review the changes that will be made.
6. Run terraform apply to create the VPC and associated resources.
7. When you are finished using the resources, run terraform destroy to delete them.

## Outputs
This module does not have any outputs. 