variable "aws_region" {
  type    = string
}

variable "aws_profile" {
  type        = string
  description = "The profile configured under ~/.aws/credentials"
}

variable "eks_name" {
  type = string
}

variable "local_wkst_ip" {
  type        = string
  description = "My local workstation IP"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID provided by the VPC module"
}

variable "app_subnet_ids" {
  type        = list(string)
  description = "Subnet ids provided by the VPC module"
}

variable "asg-desired-size" {
  description = "Desired size of the Auto Scaling Group (Nodes)"
  type = number
  default = 1
}

variable "asg-min-size" {
  description = "Minimum size of the Auto Scaling Group (Nodes)"
  type = number
  default = 1
}

variable "asg-max-size" {
  description = "Minimum size of the Auto Scaling Group (Nodes)"
  type = number
  default = 1
}