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

##################################################################################################################################################
#                                                          Deploying IAM Role
##################################################################################################################################################                  

#IAM role for lambda function that generates Faceprints from images in S3 bucket and store it in DynamoDB table

resource "aws_iam_role" "faceprints-role" {
  name = "faceprints-role"
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

#IAM role for lambda function that generates Faceprints from images in S3 bucket and store it in DynamoDB table

resource "aws_iam_policy" "faceprint-policy" {
  name = "faceprint-policy"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Sid": "CloudWatchLogGroup",
        "Effect" : "Allow",
        "Action": [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
        ],
        "Resource": "arn:aws:logs:*:*:*"
    },
    {
        "Sid": "PutItemsInDynamoDB",
        "Effect": "Allow",
        "Action": [
            "dynamodb:PutItem"
        ],
        "Resource": "arn:aws:dynamodb:*:*:table/face-prints-table"
    },
    {
        "Sid": "IndexFaceRekognitionID",
        "Effect": "Allow",
        "Action": [
            "rekognition:IndexFaces"
        ],
        "Resource": "arn:aws:rekognition:*:*:collection/*"
    },
    {
        "Sid": "FetchImagesFromS3",
        "Effect": "Allow",
        "Action": [
            "s3:GetObject",
            "s3:HeadObject"
        ],
        "Resource": "arn:aws:s3:::individuals-source-image/*"
    }
    ]
}  
EOF
}

##################################################################################################################################################
#                                                       Attaching IAM Role and Policy
################################################################################################################################################## 

#Attaching IAM role and Policy for lambda function that generates Faceprints from images in S3 bucket and store it in DynamoDB table

resource "aws_iam_role_policy_attachment" "faceprints-role-policy-attachment" {
  role = aws_iam_role.faceprints-role.id
  policy_arn = aws_iam_policy.faceprint-policy.arn
}


##################################################################################################################################################
#                                                          Deploying IAM Role
##################################################################################################################################################                  

#IAM role for EKS Cluster

resource "aws_iam_role" "eks-role" {
  name = "eks-cluster-role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Effect": "Allow",
        "Principal": {
            "Service": "eks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
    }
    ]
}
EOF
}

##################################################################################################################################################
#                                                       Attaching IAM Role and Policy
################################################################################################################################################## 

#Attaching IAM role and Policy for EKS Cluster

resource "aws_iam_role_policy_attachment" "eks-cluster-service-policy" {
  role = aws_iam_role.eks-role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

resource "aws_iam_role_policy_attachment" "eks-cluster-policy" {
  role = aws_iam_role.eks-role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}


##################################################################################################################################################
#                                                          Deploying IAM Role
##################################################################################################################################################                  

#IAM role for EKS Worker Node

resource "aws_iam_role" "eks-worker-node-role" {
  name = "eks-worker-node-role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Effect": "Allow",
        "Principal": {
            "Service": "ec2.amazonaws.com"
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

#IAM policy for EKS node group to connect with Application

resource "aws_iam_policy" "EKS-WorkerNode-Face-Rekognition-policy" {
  name = "EKS-WorkerNode-Face-Rekognition-policy"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
    "Sid": "recognisetheimage",
    "Effect": "Allow",
    "Action": [
      "rekognition:SearchFacesByImage"
    ],
    "Resource": "arn:aws:rekognition:*:*:collection/*"
  },
  {
    "Sid": "getimagedynamoDB",
    "Effect": "Allow",
    "Action": [
      "dynamodb:GetItem"
    ],
    "Resource": "arn:aws:dynamodb:*:*:table/face-prints-table"
  },
  {
    "Sid": "accesss3bucket",
    "Effect": "Allow",
    "Action": [
      "s3:GetObject",
      "s3:PutObject"
    ],
    "Resource": "arn:aws:s3:::aws-rekognition-source-bucket-logesh81098/*"
  }
    ]
}  
EOF
}



##################################################################################################################################################
#                                                       Attaching IAM Role and Policy
################################################################################################################################################## 

#Attaching IAM role and Policy for EKS Worker Node

resource "aws_iam_role_policy_attachment" "eks-cni-policy" {
    role = aws_iam_role.eks-worker-node-role.id
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "eks-worker-node-policy" {
  role = aws_iam_role.eks-worker-node-role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks-container-registry-read-only" {
  role = aws_iam_role.eks-worker-node-role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "eks-node-group-with-application" {
  role = aws_iam_role.eks-worker-node-role.id
  policy_arn = aws_iam_policy.EKS-WorkerNode-Face-Rekognition-policy.arn
}