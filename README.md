# Amazon EKS Cluster

This Terraform module includes all AWS resources needed to deploy a functional Amazon EKS cluster, such as:
- VPC (this includes subnets, multi AZ for HA capability, internet gateways, routing tables and so on)
- Security Groups
- IAM policies (attached by Roles)
- EKS Cluster iself definition
- EKS Group Nodes (this project makes use of a more modern Terraform approach to avoid tweaking Auto Scaling Groups, AMIs and bootstrap User Data)
- Kubernetes resources (to enable ALB ingress from the Kubernetes pods)

## EKS Diagram:
<img src="../assets/aws_eks.png" height="600" alt="EKS Diagram" />

## Usage

### Requirements

Make sure you have the following in your local dev environment:

- Terraform v0.12 (or newer)
- Valid AWS Account
- AWS Profile properly configured in `.aws/credentials`
- Kubernetes CLI installed (kubectl)

Then proceed as follow:

Clone the repository:

```bash
git clone https://github.com/andersonLSergio/terraform.git
```

Change your context to this module directory:
```bash
cd terraform/aws
```

Change the following variables in the root `variables.tf` file in order to meet your personal needs:
- `aws_region` - The AWS region on which you want the deployment to take effect
- `aws_profile` - Your AWS IAM account profile
- `subnet_count` - How many times you want your subnets to be replicated for HA capability
- `local_wkst_ip` - Provide your local IP reacheable from the world in worder to be allowed in the Security Group definitions

Run Terraform plan and export it to `tfplan` file:
```bash
terraform plan -out=tfplan
```

Check if everything looks good to you, then apply to effectively deploy/apply changes to the AWS resources:
```bash
terraform apply tfplan
```
> Note: If you need to change anything in the code, you should go through `plan` and `apply` again.

After the deployment finishes successfuly, you should be provided with the `kubeconfig` content that you need to add in your existing Kubeconfig file under `~/.kube`.

You'll need also to change the last line in your kubeconfig file in order to comply with your local environment:
```
      - name: AWS_PROFILE
        value: <your_aws_user_credentials_profile>
```

You can optionally create a new Kubeconfig under `~/.kube` to keep [multi clusters configuration](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/) nice and organized, then you can refer to different files like so:

Change the current `KUBECONFIG` environment variable:
```bash
export KUBECONFIG=$KUBECONFIG:$HOME/.kube/<MY_NEW_KUBE_CONF_FILE>
```
> To undo the above setting export `KUBECONFIG=$KUBECONFIG_SAVED` instead

Test your access to the cluster:
```bash
kubectl get nodes
```
Example output:
```
➜  kubectl get nodes
NAME                                       STATUS   ROLES    AGE   VERSION
ip-10-0-20-60.us-east-2.compute.internal   Ready    <none>   80m   v1.16.8-eks-e16311
```

## DANGER ZONE: Destroy Everything

If you want to wipe everything up, you can do so by simply issuing the Terraform `destroy` command in the root module context, like so:
```bash
terraform destroy
```

Then you'll be asked to confirm de deletion by typing `yes`:
```
Plan: 0 to add, 0 to change, 47 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes
```