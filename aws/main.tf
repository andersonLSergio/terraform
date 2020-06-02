module "vpc" {
  source       = "./vpc"
  aws_region   = var.aws_region
  aws_profile  = var.aws_profile
  eks_name     = var.eks_name
  subnet_count = var.subnet_count
}

module "eks" {
  source        = "./eks"
  aws_region   = var.aws_region
  aws_profile  = var.aws_profile
  eks_name      = var.eks_name
  local_wkst_ip = var.local_wkst_ip
  vpc_id        = module.vpc.vpc_id_out
}