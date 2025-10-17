provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "security" {
  source        = "./modules/security"
  vpc_id        = module.vpc.vpc_id
  ingress_ports = [22, 80, 443]
}

module "rds" {
  source          = "./modules/rds"
  private_subnets = module.vpc.private_subnets
  rds_sg_id       = module.security.rds_sg_id
  depends_on      = [module.security]
}


module "ec2" {
  source            = "./modules/ec2"
  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = module.vpc.public_subnets[0]
  security_group_id = module.security.wordpress_sg_id
  key_name          = "ssh-key"
  db_endpoint       = module.rds.db_endpoint

  depends_on = [module.rds]
}
