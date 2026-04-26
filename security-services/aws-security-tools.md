# AWS Security Services Evaluation

## Overview
AWS provides a suite of specialized security services designed to automate threat detection, vulnerability management, and compliance auditing. This section documents the evaluation of six key services within the environment.

---

## 1. Amazon Inspector
**Focus:** Vulnerability Management
Inspector was used to perform automated security assessments of the EC2 instances. It scans for unintended network exposure and software vulnerabilities.

- **Findings:** Identified "reachable" ports and outdated packages on the Linux/Windows instances.
- **Value:** Proactively discovers CVEs (Common Vulnerabilities and Exposures) before they can be exploited.

![Amazon Inspector Findings](screenshots/inspector-findings.png)

---

## 2. Amazon Macie
**Focus:** Data Privacy & PII Detection
Macie was pointed at the `tiagooctober15` bucket to discover sensitive data.

- **Outcome:** Successfully identified "fake" PII (simulated Credit Card numbers and SSNs) within the uploaded CSV files.
- **Value:** Essential for preventing data leaks by automatically identifying sensitive content in S3.

![Amazon Macie Discovery](screenshots/macie-pii.png)

---

## 3. Amazon GuardDuty
**Focus:** Threat Detection
GuardDuty monitors Log and Event streams (CloudTrail, VPC Flow Logs, DNS Logs) to detect malicious activity.

- **Finding Type:** Unauthorized access attempts, unusual API calls, and potential compromised instances.
- **Project Observation:** GuardDuty remained active throughout the project, providing a "continuous monitoring" layer.

![GuardDuty Dashboard](screenshots/guardduty-dashboard.png)

---

## 4. IAM Access Analyzer
**Focus:** Least Privilege Governance
Used to identify resources that are shared externally or have overly permissive access.

- **Result:** Confirmed that S3 buckets and IAM roles were correctly restricted to internal use only.
- **Value:** Simplifies the process of identifying and removing unnecessary external access.

---

## 5. AWS Config
**Focus:** Configuration Compliance
AWS Config was used to track changes to resources and evaluate them against security best practices (Config Rules).

- **Rule Applied:** `s3-bucket-public-read-prohibited`
- **Result:** Provided a "Non-compliant" or "Compliant" status for all buckets in the account.

![AWS Config Rules](screenshots/aws-config.png)

---

## 6. AWS Trusted Advisor
**Focus:** Security Best Practices
Trusted Advisor provided a high-level security "health check" for the entire account.

- **Key Checks:**
  - MFA on Root Account (Verified: Green)
  - Security Groups - Specific Ports Restricted (Verified: Green)
  - IAM Use (Verified: Green)

![Trusted Advisor Security](screenshots/trusted-advisor.png)

---

## Summary of Evaluated Services

| Service | Primary Purpose | Project Result |
|---|---|---|
| **Inspector** | EC2 Vulnerabilities | Found unpatched packages |
| **Macie** | S3 PII Discovery | Found simulated CC/SSN data |
| **GuardDuty** | Threat Detection | Monitored for malicious activity |
| **Config** | Policy Compliance | Verified S3 & IAM configuration |
| **Access Analyzer** | Least Privilege | Confirmed no external exposure |
| **Trusted Advisor** | Best Practices | Confirmed Root MFA and SG health |

---

➡️ Next: [Final Security Analysis](../analysis/strategy.md)
