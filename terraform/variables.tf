variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "key_pair_name" {
  description = "Name of the EC2 key pair for SSH access"
  type        = string
  default     = "CYB310-Tiago"
}

variable "admin_ip" {
  description = "Your admin IP address for SSH/RDP access (e.g. 203.0.113.0/32)"
  type        = string
  sensitive   = true
}

variable "bucket_name" {
  description = "Name of the S3 bucket for sensitive data simulation"
  type        = string
  default     = "tiagooctober15"
}
