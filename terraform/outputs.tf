output "linux_instance_id" {
  description = "EC2 Instance ID for Linux server"
  value       = aws_instance.linux.id
}

output "windows_instance_id" {
  description = "EC2 Instance ID for Windows server"
  value       = aws_instance.windows.id
}

output "linux2_instance_id" {
  description = "EC2 Instance ID for Linux 2 (private)"
  value       = aws_instance.linux2.id
}

output "primary_vpc_id" {
  description = "Primary VPC ID"
  value       = aws_vpc.primary.id
}

output "secondary_vpc_id" {
  description = "Secondary VPC ID"
  value       = aws_vpc.secondary.id
}

output "vpc_peering_id" {
  description = "VPC Peering Connection ID"
  value       = aws_vpc_peering_connection.peer.id
}

output "s3_bucket_name" {
  description = "S3 Bucket Name"
  value       = aws_s3_bucket.sensitive_data.bucket
}
