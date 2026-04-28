# AWS Cloud Security Project
> Hands-on implementation of AWS security controls following the **Principle of Least Privilege (PLP)**

---

## Project Overview
This project demonstrates the design and implementation of a secure, multi-service AWS environment. It covers identity management, network segmentation, data protection, monitoring, and threat detection — simulating the responsibilities of a real-world Cloud Security Engineer.

> **Note:** All screenshots have been sanitized to redact Account IDs and Public IPs in accordance with security best practices.

---

## Architecture Diagram
![Architecture Diagram](architecture/network-diagram.png)

---

## Repository Structure

```
aws-cloud-security/
├── ec2-security/
│   ├── ec2-setup.md          # Instance setup, security groups, CLI access, tcpdump
│   ├── server-hardening.md   # Linux & Windows hardening steps
│   └── screenshots/
├── iam-security/
│   ├── iam-setup.md          # Users, groups, MFA, least privilege policies
│   └── screenshots/
├── s3-security/
│   ├── s3-config.md          # Block Public Access, bucket policies, pre-signed URLs
│   └── screenshots/
├── monitoring-logging/
│   ├── cloudwatch.md         # Billing alarm, dashboards, detailed monitoring
│   ├── cloudtrail.md         # Event history, CSV export, Excel analysis
│   └── screenshots/
├── networking/
│   ├── vpc-peering.md        # Dual VPC setup, peering connection, routing tables
│   ├── nacl.md               # Subnet-level firewall rules (stateless)
│   └── screenshots/
├── security-services/
│   ├── aws-security-tools.md # Inspector, Macie, GuardDuty, Config, Access Analyzer, Trusted Advisor
│   └── screenshots/
├── policies/
│   ├── readme.md             # IAM & S3 JSON policy documentation
│   └── screenshots/
├── terraform/
│   ├── main.tf               # Provider configuration
│   ├── variables.tf          # Input variables
│   ├── vpc.tf                # VPCs, subnets, peering, route tables
│   ├── ec2.tf                # EC2 instances & security groups
│   ├── iam.tf                # Users, groups, policies
│   ├── s3.tf                 # Bucket, encryption, access controls
│   ├── cloudwatch.tf         # Alarms, dashboards, SNS
│   ├── nacl.tf               # Network ACL rules
│   ├── outputs.tf            # Resource output values
│   └── README.md             # How to deploy with Terraform
└── analysis/
    └── strategy.md           # First-week security plan & PLP strategy
```

---

## Key Components

### 🖥️ EC2 & Server Hardening
- Deployed Linux (Amazon Linux 2023) and Windows Server instances
- Security Groups configured with **minimum required ports only** (RDP 3389, ICMP)
- Linux hardened: root login disabled, `ufw` firewall, `auditd` logging, patching
- Windows hardened: MFA, Defender Firewall, Event Viewer, PowerShell auditing
- Network traffic captured and analyzed using `tcpdump`

### 🔐 IAM & Least Privilege
- Root account secured: MFA enabled, access keys removed
- 5 IAM users organized into 2 groups (`Calvin`, `Osborne`) by job function
- Dedicated admin user (`Adeyemi`) for daily operations — root never used
- Explicit **Deny** policies tested and verified (EC2 access blocked for specific user)
- IAM Credential Report and Access Analyzer used for auditing

### 🪣 S3 Data Protection
- Block Public Access enabled at account and bucket level
- Simulated PII data (SSNs, credit card numbers) uploaded for security testing
- Resource-based bucket policy denying access to specific IAM user (`amarrow`)
- Pre-signed URLs used for controlled temporary access (expiration tested)

### 📊 Monitoring & Logging
- CloudWatch billing alarm set at $1 threshold with SNS notification
- Custom dashboard tracking CPU, Network In/Out, EBS, and API calls
- CloudTrail event history exported to CSV and analyzed in Excel
- 12 unique users identified and baseline activity established

### 🌐 Networking
- Two VPCs with non-overlapping CIDRs (`172.31.0.0/16` and `10.0.0.0/16`)
- VPC Peering (`linux1andlinux2`) for private cross-VPC communication
- Custom NACL rules enforcing least privilege at the subnet level
- Private instance (Linux 2) with no public IP exposure

### 🛡️ AWS Security Services
| Service | Purpose | Outcome |
|---|---|---|
| Amazon Inspector | EC2 vulnerability scanning | Identified unpatched packages |
| Amazon Macie | S3 PII detection | Found simulated CC/SSN data |
| Amazon GuardDuty | Threat detection | Continuous monitoring active |
| AWS Config | Compliance rules | S3 public access verified compliant |
| IAM Access Analyzer | External access detection | Zero external exposure confirmed |
| AWS Trusted Advisor | Best practice health check | Root MFA & SG rules verified green |

### ⚙️ Infrastructure as Code (Terraform)
The entire environment is documented as Terraform code for reproducibility.
- VPCs, subnets, peering, and route tables
- EC2 instances and security groups
- IAM users, groups, and policies
- S3 bucket with encryption and access controls
- CloudWatch alarms and dashboards
- Network ACLs

➡️ See [`terraform/README.md`](terraform/README.md) for deployment instructions.

---

## Skills Demonstrated
- AWS IAM & Least Privilege Enforcement
- VPC Design, Subnetting & Network Segmentation
- S3 Data Protection & Access Control
- CloudWatch Monitoring & CloudTrail Auditing
- Threat Detection (GuardDuty, Macie, Inspector)
- Network Security (Security Groups, NACLs)
- Infrastructure as Code (Terraform)
- Incident Analysis & Log Forensics

---

## Lessons Learned
- Explicit `Deny` in IAM always overrides `Allow` — even for admins
- NACLs are stateless — both inbound AND outbound rules must be configured
- Most cloud breaches originate from misconfigured S3 or over-permissioned IAM
- CloudTrail is the single most important tool for post-incident investigation
- Block Public Access should be the **first** action taken on any new AWS account

---

## Cost & Cleanup
All resources were terminated upon project completion. Total estimated cost: **< $5**
- All EC2 instances stopped and terminated
- S3 buckets emptied and deleted
- AWS account deactivated after project completion
