terraform {
    backend "s3" {
        bucket         = "wafi-terraform-state"
        key            = "terraform.tfstate"
        region         = "us-east-1"
        encrypt        = true
    }
}

data "aws_availability_zones" "available" {}

module "app-vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "5.5.1"

    name = var.vpc
    cidr = var.vpc_cidr_block
    private_subnets = var.private_subnet_cidr_blocks
    public_subnets = var.public_subnet_cidr_blocks
    azs = data.aws_availability_zones.available.names 

    enable_nat_gateway = true
    single_nat_gateway = true
    enable_dns_hostnames = true

    tags = {
        "kubernetes.io/cluster/wafi-eks-cluster" = "shared"
    }

    public_subnet_tags = {
        "kubernetes.io/cluster/wafi-eks-cluster" = "shared"
        "kubernetes.io/role/elb" = "1" 
    }

    private_subnet_tags = {
        "kubernetes.io/cluster/wafi-eks-cluster" = "shared"
        "kubernetes.io/role/internal-elb" = "1" 
    }

    map_public_ip_on_launch = true
}

module "eks_cluster" {
    source  = "terraform-aws-modules/eks/aws"
    version = "19.21.0"

    cluster_name =  var.cluster_name
    cluster_version = "1.27"

    subnet_ids = concat(module.app-vpc.private_subnets, module.app-vpc.public_subnets)
    vpc_id = module.app-vpc.vpc_id

    cluster_endpoint_private_access = true

    cluster_endpoint_public_access = true

    tags = {
        environment = "development"
        application = var.cluster_name
    }

    eks_managed_node_groups = {
        dev = {
            min_size     = 1
            max_size     = 2
            desired_size = 1

            instance_types = ["t2.medium"]
        }
    }
}

output "subnet_ids" {
    value = concat(module.app-vpc.private_subnets, module.app-vpc.public_subnets)
}

resource "null_resource" "configure_kubectl" {
    provisioner "local-exec" {
        command = "aws eks --region ${var.region} update-kubeconfig --name ${module.eks_cluster.cluster_name}"
    }

    depends_on = [module.eks_cluster]
}