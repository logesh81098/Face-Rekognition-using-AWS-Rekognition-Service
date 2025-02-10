##################################################################################################################################################
#                                                          Deploying IAM Role
##################################################################################################################################################                  

#IAM role for lambda function that creates collection ID in AWS Rekognition Service

resource "aws_iam_role" "rekognition-collection-id-role" {
  name = "rekognition-collection-id-role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Effect": "Allow",
        "Principal": {
         "Service": "lambda.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
    }
    ]

}  
EOF
}

##################################################################################################################################################
#                                                       Deploying IAM Policy
################################################################################################################################################## 

#IAM policy for lambda function that creates collection ID in AWS Rekognition Service

resource "aws_iam_policy" "rekognition-collection-id-policy" {
  name = "rekognition-collection-id-policy"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Sid": "CollectingRekognition",
        "Effect": "Allow",
        "Action": [
            "rekognition:CreateCollection",
            "rekognition:DeleteCollection",
            "rekognition:ListCollections"
        ],
        "Resource": "*"
    },
    {
        "Sid": "CloudWatchLogGroup",
        "Effect": "Allow",
        "Action": [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
        ],
        "Resource": "arn:aws:logs:*:*:*"
    }

    ]
}  
EOF
}


##################################################################################################################################################
#                                                       Attaching IAM Role and Policy
################################################################################################################################################## 

#Attaching IAM role and Policy for lambda function that creates collection ID in AWS Rekognition Service

resource "aws_iam_role_policy_attachment" "rekognition-collection-id-role-policy-attachment" {
  role = aws_iam_role.rekognition-collection-id-role.id
  policy_arn = aws_iam_policy.rekognition-collection-id-policy.arn
}