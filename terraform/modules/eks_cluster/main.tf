# modules/eks_cluster/main.tf
# data "aws_subnet_ids" "default" {
#     default_vpc = true
# }

# resource "aws_eks_cluster" "eks_cluster" {
#     name     = var.eks_cluster_name
#     role_arn = var.eks_cluster_role_arn

#     vpc_config {
#         subnet_ids = data.aws_subnet_ids.default.ids
#     }

#     depends_on = [aws_iam_role_policy_attachment.eks_cluster]
# }