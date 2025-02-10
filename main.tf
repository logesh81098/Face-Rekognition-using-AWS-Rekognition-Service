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