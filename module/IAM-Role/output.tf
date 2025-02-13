output "rekognition-collection-id-role" {
  value = aws_iam_role.rekognition-collection-id-role.arn
}

output "faceprints-role" {
  value = aws_iam_role.faceprints-role.arn
}

output "eks-cluster-role" {
  value = aws_iam_role.eks-role.arn
}

output "eks-worker-node" {
  value = aws_iam_role.eks-worker-node-role.arn
}