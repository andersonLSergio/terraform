variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "aws_profile" {
  type        = string
  description = "The profile configured under ~/.aws/credentials"
  default     = "personal"
}

variable "eks_name" {
  type    = string
  default = "eks-us"
}

variable "subnet_count" {
  type        = number
  description = "The number of subnets to create per type to ensure high availability."
  default     = 2
}

variable "local_wkst_ip" {
  type        = string
  description = "My local workstation IP"
}