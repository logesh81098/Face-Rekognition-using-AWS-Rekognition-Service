module "s3" {
  source = "./module/s3"
  faceprints-lambda-arn = module.lambda.faceprints-lambda-arn
}

module "iam-role" {
  source = "./module/IAM-Role"
}

module "lambda" {
  source = "./module/Lambda Function"
  face-rekognition-collection-id-role = module.iam-role.rekognition-collection-id-role
  faceprints-role = module.iam-role.faceprints-role
  source-s3-bucket-arn = module.s3.source-bucket-arn
}

module "dynamodb" {
  source = "./module/DynamoDB"
}

module "vpc" {
  source = "./module/VPC"
}

module "eks-cluster" {
  source = "./module/EKS-Cluster"
  eks-cluster-role = module.iam-role.eks-cluster-role
  eks-worker-node-role = module.iam-role.eks-worker-node
  subnet-1 = module.vpc.subnet-1
  subnet-2 = module.vpc.subnet-2
  eks-worker-node-security-group = module.security-group.eks-worker-node-security-group
}

module "security-group" {
  source = "./module/Security-Group"
  vpc-id = module.vpc.vpc-id
}