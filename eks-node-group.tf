resource "aws_eks_node_group" "private" {
  cluster_name    = aws_eks_cluster.myeks.name
  node_group_name = "private-node-group-${var.env}"
  node_role_arn   = aws_iam_role.node-group-role.arn
  subnet_ids      = [aws_subnet.private["private-1"].id, aws_subnet.private["private-2"].id]

  labels = {
    "type" = "private"
  }

  instance_types = ["t3.small"]
  disk_size      = 25 # default 20G

  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.node-group-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-group-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-group-AmazonEC2ContainerRegistryReadOnly
  ]

  tags = {
    Environment = var.env
  }
}

resource "aws_eks_node_group" "public" {
  cluster_name    = aws_eks_cluster.myeks.name
  node_group_name = "public-node-group-${var.env}"
  node_role_arn   = aws_iam_role.node-group-role.arn
  subnet_ids      = [aws_subnet.public["public-1"].id, aws_subnet.public["public-2"].id]

  labels = {
    "type" = "public"
  }

  instance_types = ["t3.small"]
  disk_size      = 25 # default 20G

  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.node-group-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-group-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-group-AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = {
    Environment = var.env
  }
}