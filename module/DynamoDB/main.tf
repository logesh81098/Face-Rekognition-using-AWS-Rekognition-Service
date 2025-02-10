##################################################################################################################################################
#                                                   Deploying DynamoDB
##################################################################################################################################################

#Deploying DynamoDB table to store the Faceprints

resource "aws_dynamodb_table" "faceprints-table" {
  name = "face-prints-table"
  hash_key = "RekognitionID"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    type = "S"
    name = "full_name"
  }
  attribute {
    type = "S"
    name = "RekognitionID"
  }
  global_secondary_index {
    name            = "full_name-index"
    hash_key        = "full_name"
    projection_type = "ALL"
  }
  tags = {
    Name = "faceprints-table"
    Project = "Face Rekognition"
  }

}