data "aws_eks_cluster_auth" "tf_eks" {
  name = aws_eks_cluster.tf_eks.name
}

provider "kubernetes" {
  host                   = aws_eks_cluster.tf_eks.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.tf_eks.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.tf_eks.token
  load_config_file       = false
}