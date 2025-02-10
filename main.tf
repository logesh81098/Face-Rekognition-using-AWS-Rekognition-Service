module "s3" {
  source = "./module/s3"
}

module "iam-role" {
  source = "./module/IAM-Role"
}

module "lambda" {
  source = "./module/Lambda Function"
  face-rekognition-collection-id-role = module.iam-role.rekognition-collection-id-role
}