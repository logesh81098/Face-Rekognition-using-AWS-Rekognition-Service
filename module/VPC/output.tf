output "subnet-1" {
  value = aws_subnet.public-subnet-1.id
}

output "subnet-2" {
  value = aws_subnet.public-subnet-2.id
}

output "vpc-id" {
  value = aws_vpc.Face-Rekognition-vpc.id
}