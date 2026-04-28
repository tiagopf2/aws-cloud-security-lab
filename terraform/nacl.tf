# -----------------------------------------------
# NETWORK ACL — Public Subnet (Primary VPC)
# -----------------------------------------------
resource "aws_network_acl" "public_nacl" {
  vpc_id     = aws_vpc.primary.id
  subnet_ids = [aws_subnet.primary_public.id]

  # ---- INBOUND RULES ----

  # Rule 100: Allow SSH from admin IP only
  ingress {
    rule_no    = 100
    protocol   = "tcp"
    action     = "allow"
    cidr_block = var.admin_ip
    from_port  = 22
    to_port    = 22
  }

  # Rule 200: Allow HTTP
  ingress {
    rule_no    = 200
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  # Rule 300: Allow ICMP (Ping)
  ingress {
    rule_no    = 300
    protocol   = "icmp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = -1
    to_port    = -1
    icmp_type  = -1
    icmp_code  = -1
  }

  # Rule 400: Allow ephemeral ports (return traffic — stateless requirement)
  ingress {
    rule_no    = 400
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  # Default: Deny all other inbound
  ingress {
    rule_no    = 32767
    protocol   = "-1"
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  # ---- OUTBOUND RULES ----

  # Allow all outbound traffic
  egress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "public-nacl-tiago"
  }
}
