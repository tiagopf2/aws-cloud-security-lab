# IAM — Identity & Access Management

## Overview
This section covers the implementation of the **Principle of Least Privilege (PLP)** through IAM. The configuration focuses on securing the root account, managing user identities via groups, and applying granular permission policies.

---

## Root Account Security
The AWS Root account was secured immediately as a priority "First-Week" action.

- **MFA Enforced:** Multi-Factor Authentication was enabled (Virtual MFA device).
- **No Access Keys:** All active access keys for the root user were removed to prevent programmatic leaks.
- **Limited Usage:** The root account is not used for daily administrative tasks.

![Root MFA Proof](screenshots/root-mfa.png)

---

## User and Group Management
Following best practices, users are not assigned permissions directly. Instead, they are placed into groups with specific job-function policies.

### IAM Individual Users
5 individual user accounts were created:
1. `Userad`
2. `Userbe`
3. `Userce`
4. `Userde`
5. `Usere`

### IAM Groups
Users were organized into two distinct groups to manage permissions efficiently:

| Group Name | Member Count | Purpose |
|---|---|---|
| **Calvin** | 2 Users | Tier 1 Support / Limited Access |
| **Osborne** | 3 Users | Tier 2 Support / Management |

![IAM Groups Dashboard](screenshots/iam-groups.png)

---

## Daily Administration Strategy
To minimize risk, a dedicated IAM user account was created for day-to-day administrative tasks. This account has the `AdministratorAccess` policy attached, allowing full management of the environment without ever logging into the root account.

- **User Name:** `Adeyemi`
- **Policy:** `AdministratorAccess` (AWS Managed)

![Admin User Console](screenshots/admin-user.png)

---

## Least Privilege Enforcement (Identity-Based Policies)
To demonstrate the enforcement of Least Privilege, specific "Deny" policies were created to restrict access even when other permissions might exist.

### Policy Example: `ec2access` (Deny Policy)
A customer-managed policy was created to explicitly deny all EC2 actions.

**JSON Policy Code:**
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Deny",
            "Action": "ec2:*",
            "Resource": "*"
        }
    ]
}
```

### Testing the Policy
This policy was attached to the user `aimaroroz`.
- **Result:** When the user attempted to view or launch instances in the EC2 console, they received an "API Error" or "Unauthorized" message.

![Deny Policy Test](screenshots/deny-policy-error.png)

---

## Auditing and Compliance Tools

### 1. Credential Report
A CSV report was generated to audit the security status of all users. This report lists:
- Password enabled/age
- MFA status (Active/Inactive)
- Access key rotation status

> **Insight:** This tool is essential for identifying inactive accounts or users who haven't enabled MFA.

### 2. IAM Access Analyzer
Used to identify resources that are shared with an external entity or have overly permissive access.

- **Findings:** 0 (Reflecting good security hygiene).
- **Value:** Proactively prevents public exposure of internal roles or buckets.

![Access Analyzer](screenshots/iam-analyzer.png)

---

## IAM Best Practices Summary
- [x] **MFA Everywhere:** Enforced for root and highly privileged users.
- [x] **No Root Access Keys:** Eliminates the risk of full account compromise via leaked keys.
- [x] **Groups over Users:** Simplifies permission management.
- [x] **Least Privilege:** Users only have what they need to perform their job functions.
- [x] **Regular Audits:** Using Credential Reports to monitor account health.

---

➡️ Next: [S3 Security](../s3-security/s3-config.md)
