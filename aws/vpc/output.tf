# export the vpc id to be used in EKS module
output "vpc_id_out" {
  value = aws_vpc.eks_vpc.id
}