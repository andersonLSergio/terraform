locals {
  kubeconfig = <<KUBECONFIG
 
 
apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.tf_eks.endpoint}
    certificate-authority-data: ${aws_eks_cluster.tf_eks.certificate_authority.0.data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
      - token
      - -i
      - eks-us
      command: aws-iam-authenticator
      env:
      - name: AWS_PROFILE
        value: <your_aws_user_credentials_profile>
KUBECONFIG
}