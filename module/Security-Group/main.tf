##################################################################################################################################################
#                                                      Deploying Security Group
##################################################################################################################################################

#Deploying Security Group to access application running on EC2 instance

resource "aws_security_group" "eks-cluster-security-group" {
  name = "eks-cluster-security-group"
  vpc_id = var.vpc-id
  description = "Security Group to access Face Rekognition application running on EC2 instance"
  ingress {
    from_port = 81
    to_port = 81
    protocol = "tcp"
    cidr_blocks = [ var.application-cidr ]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "eks-cluster-security-group"
  }
}