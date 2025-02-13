##################################################################################################################################################
#                                                       Deploying EKS Cluster
##################################################################################################################################################

#Deploying EKS Cluster to run application 

resource "aws_eks_cluster" "face-rekogntion-cluster" {
  name = "face-rekogntion-cluster"
  role_arn = var.eks-cluster-role
  vpc_config {
    subnet_ids = [var.subnet-1, var.subnet-2]
  }
  tags = {
    Name = "face-rekogntion-cluster"
  }
}


##################################################################################################################################################
#                                                       Deploying EKS Worker Node
##################################################################################################################################################

#Deploying EKS worker node to run application 

resource "aws_eks_node_group" "face-rekognition-node-group" {
  node_group_name = "face-rekognition-node-group"
  cluster_name = aws_eks_cluster.face-rekogntion-cluster.id
  node_role_arn = var.eks-worker-node-role
  scaling_config {
    max_size = "2"
    desired_size = "1"
    min_size = "1"
  }
  instance_types = ["t3.medium"]
  subnet_ids = [ var.subnet-1, var.subnet-2 ]
  tags = {
    Name = "face-rekogntion-worker-node"
  }
}
