##################################################################################################################################################
#                                                           Deploying VPC
##################################################################################################################################################

#Deploying VPC to run application on K8s

resource "aws_vpc" "Face-Rekognition-vpc" {
  cidr_block = var.vpc-cidr
  tags = {
    Name = "Face-Rekognition-vpc"
  }
}

##################################################################################################################################################
#                                                         Deploying Subnets
##################################################################################################################################################

#Deploying public subnets to run application on public facing instance

resource "aws_subnet" "public-subnet-1" {
  vpc_id = aws_vpc.Face-Rekognition-vpc.id
  cidr_block = var.public-subnet-1-cidr
  availability_zone = var.az1
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-1"
  }
}


resource "aws_subnet" "public-subnet-2" {
  vpc_id = aws_vpc.Face-Rekognition-vpc.id
  cidr_block = var.public-subnet-2-cidr
  availability_zone = var.az2
  map_public_ip_on_launch = true

}


##################################################################################################################################################
#                                                   Deploying Internet Gateway
##################################################################################################################################################

resource "aws_internet_gateway" "Face-Rekognition-IGW" {
  vpc_id = aws_vpc.Face-Rekognition-vpc.id
  tags = {
    Name = "Face-Rekognition-IGW"
  }
}


##################################################################################################################################################
#                                                     Deploying Route Table
##################################################################################################################################################

resource "aws_route_table" "Face-Rekognition-RT" {
  vpc_id = aws_vpc.Face-Rekognition-vpc.id
  route {
    gateway_id = aws_internet_gateway.Face-Rekognition-IGW.id
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    Name = "Face-Rekognition-RT"
  }
}

##################################################################################################################################################
#                                                     Route Table Association
##################################################################################################################################################


resource "aws_route_table_association" "subnet-1" {
  route_table_id = aws_route_table.Face-Rekognition-RT.id
  subnet_id = aws_subnet.public-subnet-1.id
}

resource "aws_route_table_association" "subnet-2" {
  route_table_id = aws_route_table.Face-Rekognition-RT.id
  subnet_id = aws_subnet.public-subnet-2.id
}

