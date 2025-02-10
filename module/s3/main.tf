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