# -----------------------------------------------
# SECURITY GROUPS
# -----------------------------------------------

# Linux Security Group — SSH only from admin IP
resource "aws_security_group" "linux_sg" {
  name        = "linux-sg-tiago"
  description = "Allow SSH from admin IP only"
  vpc_id      = aws_vpc.primary.id

  ingress {
    description = "SSH from admin only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_ip]
  }

  ingress {
    description = "ICMP Ping"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "linux-sg"
  }
}

# Windows Security Group — RDP only from admin IP
resource "aws_security_group" "windows_sg" {
  name        = "windows-sg-tiago"
  description = "Allow RDP from admin IP only"
  vpc_id      = aws_vpc.primary.id

  ingress {
    description = "RDP from admin only"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = [var.admin_ip]
  }

  ingress {
    description = "ICMP Ping"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "windows-sg"
  }
}

# -----------------------------------------------
# EC2 INSTANCES
# -----------------------------------------------

# Linux Instance (Primary VPC)
resource "aws_instance" "linux" {
  ami                    = "ami-0c02fb55956c7d316" # Amazon Linux 2023 (us-east-1)
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.primary_public.id
  key_name               = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.linux_sg.id]

  tags = {
    Name = "CYB310-Linux-Tiago"
  }
}

# Windows Instance (Primary VPC)
resource "aws_instance" "windows" {
  ami                    = "ami-0f9c44e98edf38a2b" # Windows Server 2022 (us-east-1)
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.primary_public.id
  key_name               = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.windows_sg.id]

  tags = {
    Name = "CYB310-Windows-Tiago"
  }
}

# Linux 2 Instance (Secondary VPC — Private, no public IP)
resource "aws_instance" "linux2" {
  ami                         = "ami-0c02fb55956c7d316" # Amazon Linux 2023 (us-east-1)
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.secondary_private.id
  key_name                    = var.key_pair_name
  associate_public_ip_address = false

  tags = {
    Name = "CYB310-Linux2-Tiago"
  }
}
