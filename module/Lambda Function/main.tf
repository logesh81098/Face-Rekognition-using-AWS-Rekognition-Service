##################################################################################################################################################
#                                                   Archive the lambda code
##################################################################################################################################################

data "archive_file" "rekognition-collection-code" {
  type = "zip"
  source_dir = "module/Lambda Function"
  output_path = "module/Lambda Function/face-rekognition-collection-id.zip"
}




##################################################################################################################################################
#                                                   Deploying Lambda Function
##################################################################################################################################################

#Lambda function to create Collection in Rekogntion service
resource "aws_lambda_function" "face-rekognition-collection-id" {
  function_name = "face-rekognition-collection-id"
  runtime = "python3.8"
  handler = "face-rekognition-collection-id.lambda_handler"
  role = var.face-rekognition-collection-id-role
  filename = "module/Lambda Function/face-rekognition-collection-id.zip"
  timeout = "20"
  tags = {
    Name = "face-rekognition-collection-id"
  }
}


##################################################################################################################################################
#                                                   Archive the lambda code
##################################################################################################################################################

data "archive_file" "faceprints-code" {
  type = "zip"
  source_dir = "module/Lambda Function"
  output_path = "module/Lambda Function/faceprints.zip"
}


##################################################################################################################################################
#                                                   Deploying Lambda Function
##################################################################################################################################################

#Lambda function to create faceprints and store it in DynamoDB table

resource "aws_lambda_function" "faceprints" {
  function_name = "faceprints-lambda"
  role = var.faceprints-role
  timeout = "20"
  handler = "faceprints.lambda_handler"
  filename = "module/Lambda Function/faceprints.zip"
  runtime = "python3.8"
  tags = {
    Name = "faceprints-lambda"
  }
}

##################################################################################################################################################
#                                                   S3 bucket to trigger lambda
##################################################################################################################################################

resource "aws_lambda_permission" "s3-trigger-lambda" {
  function_name = aws_lambda_function.faceprints.function_name
  statement_id = "s3-trigger-lambda"
  principal = "s3.amazonaws.com"
  action = "lambda:InvokeFunction"
  source_arn = var.source-s3-bucket-arn
}


