# Terraform configuration

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.0.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

module "ec2" {
  source = "./modules/ec2"
  instance_type = "t2.micro"
  ami_id = "ami-a0cfeed8"
  vpc_id            = module.vpc.vpc_id
  private_subnet    = module.vpc.private_subnet_id
  public_subnet          = module.vpc.public_subnet_id
  tags = {
    project  = "learning"
    Environment = "dev"
  }
}

module "vpc" {
  source = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  subnet1_cidr = "10.0.1.0/24"
  subnet2_cidr = "10.0.3.0/24"
  tags = {
    project  = "learning"
    Environment = "dev"
  }
}