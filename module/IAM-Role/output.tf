output "rekognition-collection-id-role" {
  value = aws_iam_role.rekognition-collection-id-role.arn
}

output "faceprints-role" {
  value = aws_iam_role.faceprints-role.arn
}