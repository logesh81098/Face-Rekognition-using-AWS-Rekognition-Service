module "s3" {
  source = "./module/s3"
}

module "iam-role" {
  source = "./module/IAM-Role"
}