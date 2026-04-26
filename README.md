# AWS Cloud Security Project (Least Privilege + Monitoring Lab)

## Overview
This project demonstrates secure configuration and monitoring of core AWS services (EC2, S3, IAM, VPC, CloudWatch, CloudTrail) following the Principle of Least Privilege (PLP). The goal is to reduce risk from over-permissioned identities, exposed storage, and weak network boundaries, while improving detection through logging and alerts.

## Key Objectives
- Enforce least privilege using IAM users, groups, and policies
- Harden compute (Linux + Windows) and validate access controls
- Secure S3 against public exposure and unauthorized access
- Build monitoring/alerting with CloudWatch and auditability with CloudTrail
- Segment networking with VPC design, routing, peering, SGs, and NACLs
- Evaluate AWS-native security services for detection and governance

## Architecture (High Level)
- 2 EC2 instances: Linux + Windows Server
- 2 VPCs with different CIDRs and VPC peering
- Private instance with no direct public access
- CloudTrail logging + CloudWatch dashboards/alarms
- S3 buckets containing fake “sensitive” test data

## What I Implemented

### 1) EC2 Security Basics
- Deployed Linux and Windows instances
- Restricted Security Groups to required ports only (e.g., RDP 3389, ICMP as needed)
- Validated access and basic commands (echo/ping)
- Observed system activity and potential anomalies (processes, users, resource usage)

### 2) Server Hardening
**Linux**
- Disabled direct root login; used sudo
- Enabled firewall (ufw)
- Regular patching (apt/yum)
- Auditing with auditd

**Windows**
- Enabled firewall + Defender
- Log review via Event Viewer
- PowerShell automation for administration tasks
- MFA/AD approach (design + best practices)

### 3) Network Monitoring
- Captured traffic with tcpdump to observe real network activity (HTTP/SSH)
- Used packet limits and verbose output to analyze sessions

### 4) IAM (Least Privilege)
- Created 5 users and 2 groups
- Enforced MFA (especially root)
- Avoided root for daily tasks
- Applied least privilege policies (example deny policy included in /policies)

### 5) S3 Storage Security
- Created buckets containing fake sensitive data
- Enabled Block Public Access
- Applied bucket policies (including explicit deny)
- Tested pre-signed URLs for temporary access
- Documented misconfiguration risk patterns

### 6) Monitoring & Alerts
**CloudWatch**
- Billing alarm with low threshold
- Dashboard for CPU + network metrics
- Used metrics to detect potential anomalies (unexpected spikes)

**CloudTrail**
- Logged management events (e.g., StartInstances/StopInstances, ConsoleLogin, PutObject)
- Exported logs and performed basic analysis (unique users, activity review)

### 7) VPC & Networking
- Created 2 VPCs with different CIDRs
- Configured VPC peering and routing
- Used SGs + NACLs with least privilege inbound rules
- Ensured one instance remained private (no public exposure)

### 8) AWS Security Services Evaluated
- Inspector, Trusted Advisor, Macie, GuardDuty, Access Analyzer, AWS Config
- Documented what each service provides (vuln scanning, threat detection, config drift, sensitive data discovery, etc.)

## Evidence / Screenshots
See `evidence/` for sanitized outputs and screenshots.

## Security Notes (Public Repo Safety)
This repository contains no real credentials and no real sensitive data.
Any “sensitive data” used in S3 is intentionally fake for demonstration.

## Cleanup / Cost Control
- Stop/terminate EC2 instances when not in use
- Delete test S3 buckets/objects
- Remove CloudWatch dashboards/alarms if not needed
- Disable services if they incur costs in your account

## Lessons Learned
- Most cloud security risk is configuration-driven
- Least privilege + visibility (logging/monitoring) prevents and detects common failures
- S3 misconfigurations and IAM over-permissioning are the biggest repeat offenders
