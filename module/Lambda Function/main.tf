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






