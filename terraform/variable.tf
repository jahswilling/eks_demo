variable "region" {
    description = "AWS region"
    type        = string
    default     = "us-east-1"  # Change to your preferred region
}

variable "vpc" {
    type = string
    description = ""
    default = "wafi-vpc"
}

variable "cluster_name" {
    description = "Wafi EKS cluster"
    type        = string
    default     = "wafi-eks-cluster"
}

variable "vpc_cidr_block" {
    description = "CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/16"
}

variable "private_subnet_cidr_blocks" {
    description = "CIDR blocks for private subnets"
    type        = list(string)
    default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnet_cidr_blocks" {
    description = "CIDR blocks for public subnets"
    type        = list(string)
    default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}
