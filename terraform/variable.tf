variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "cluster_version" {
  description = "EKS Cluster Version"
  type        = string
}

variable "subnet_ids" {
  description = "List of Subnet IDs"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "desired_capacity" {
  description = "Desired Capacity for Node Group"
  type        = number
}

variable "max_capacity" {
  description = "Maximum Capacity for Node Group"
  type        = number
}

variable "min_capacity" {
  description = "Minimum Capacity for Node Group"
  type        = number
}

variable "instance_type" {
  description = "Instance Type for Node Group"
  type        = string
}

variable "create_cloudwatch_log_group" {
  description = "Flag to create CloudWatch Log Group"
  type        = bool
}
