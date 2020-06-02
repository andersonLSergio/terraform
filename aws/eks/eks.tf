### EKS Definition ###
resource "aws_eks_cluster" "tf_eks" {
  name            = var.eks_name
  role_arn        = aws_iam_role.tf-eks-master.arn

  vpc_config {
    security_group_ids = [aws_security_group.tf-eks-master.id]
    subnet_ids         = var.app_subnet_ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy,
  ]
}

### Node Groups ###
resource "aws_eks_node_group" "node-group" {
  cluster_name    = var.eks_name
  node_group_name = "eks-node-group"
  node_role_arn   = aws_iam_role.tf-eks-node.arn
  subnet_ids      = var.app_subnet_ids

  scaling_config {
    desired_size = var.asg-desired-size
    min_size     = var.asg-min-size
    max_size     = var.asg-max-size
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_eks_cluster.tf_eks
  ]
}