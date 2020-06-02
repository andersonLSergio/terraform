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
