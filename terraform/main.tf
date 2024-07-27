provider "aws" {
  region = "us-west-2"
}

# Check if the CloudWatch Log Group already exists
data "aws_cloudwatch_log_group" "existing" {
  name = "/aws/eks/${var.cluster_name}/cluster"
}

# Determine whether to create the log group
locals {
  create_log_group = var.create_cloudwatch_log_group && data.aws_cloudwatch_log_group.existing.name == ""
}

# Create the CloudWatch Log Group if it does not already exist
resource "aws_cloudwatch_log_group" "this" {
  count = local.create_log_group ? 1 : 0
  name  = "/aws/eks/${var.cluster_name}/cluster"

  lifecycle {
    prevent_destroy = true
  }
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "18.29.0" # Use the appropriate version

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = var.vpc_id
  subnet_ids      = var.subnet_ids

  eks_managed_node_groups = {
    eks_nodes = {
      desired_capacity = var.desired_capacity
      max_capacity     = var.max_capacity
      min_capacity     = var.min_capacity
      instance_type    = var.instance_type
    }
  }
}
