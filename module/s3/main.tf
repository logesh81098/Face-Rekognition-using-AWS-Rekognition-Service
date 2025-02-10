##################################################################################################################################################
#                                                        Source S3 Bucket
##################################################################################################################################################

#S3 bucket to store the source photographs that will be utilized by the Rekognition service to identify the individuals

resource "aws_s3_bucket" "source-bucket" {
  bucket = "individuals-source-image"
  tags = {
    Name = "individuals-source-image"
    Project = "Face Recognition"
  }
}


##################################################################################################################################################
#                                                   S3 object upload to trigger lambda
##################################################################################################################################################

resource "aws_s3_bucket_notification" "s3-trigger-lambda" {
  bucket = aws_s3_bucket.source-bucket.id
  lambda_function {
    lambda_function_arn = var.faceprints-lambda-arn
    events = ["s3:ObjectCreated:*"]
  }
}