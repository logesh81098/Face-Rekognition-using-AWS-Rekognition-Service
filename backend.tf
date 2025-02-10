terraform {
  backend "s3" {
    bucket = "terraform-backend-files-logesh"
    key = "Face-Rekognition-using-AWS-Rekognition-Service.tfstate"
    region = "us-east-1"
  }
}