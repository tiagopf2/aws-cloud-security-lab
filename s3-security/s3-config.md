# S3 Storage Security

## Overview

Amazon S3 is a frequent target for data breaches due to misconfigurations. This section demonstrates how to secure S3 buckets using **Block Public Access**, **Bucket Policies**, and **Pre-signed URLs** to protect sensitive data.

---

## 1\. Bucket Creation & Data Simulation

To test security controls, buckets were created with "fake" sensitive data (simulating SSNs, credit card numbers, and PII) using data generation tools like `dlptest.com`.

* **Bucket Name:** `tiagooctober15`

* **Region:** `us-east-1`

* **Content:** `csv_file.png` (Simulated PII spreadsheet)

![S3 Bucket Overview](screenshots/s3-bucket-setup.png)

---

## 2\. Hardening: Block Public Access

Access was locked down at the account and bucket levels. This is the **#1 recommendation** for S3 security to prevent accidental data leaks.

* **Status:** **On** (Block all public access)

* **Effect:** Ensures that even if a policy or ACL attempts to make an object public, AWS will override it and keep the data private.

![Block Public Access Settings](screenshots/s3-block-public.png)

---

## 3\. Resource-Based Policies (Bucket Policies)

A Bucket Policy was implemented to explicitly deny access to a specific IAM user, demonstrating how resource-level controls provide a "defense-in-depth" layer.

### Scenario: Restricting User 'amarrow'

Even if user `amarrow` had broad S3 permissions, this bucket policy prevents them from interacting with the `tiagooctober15` bucket.

**Policy Implementation:**

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Deny",
            "Principal": {
                "AWS": "arn:aws:iam:043309532723:user/amarrow"
            },
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::tiagooctober15/*"
        }
    ]
}
```

**Result:** When logged in as `amarrow`, the AWS console displays:

> "You don't have permission to list buckets"

![S3 Permission Denied](screenshots/s3-deny-error.png)

---

## 4\. Controlled Temporary Access: Pre-signed URLs

When legitimate temporary access is needed for a private object, a **Pre-signed URL** is generated. This allows access for a specific duration without making the bucket public.

### Proof of Concept:

1. **Creation:** A pre-signed URL was generated for `P6250092.jpg`.

2. **Success:** The image was successfully viewed in a browser using the unique tokenized URL.

3. **Expiration:** After the set time, the URL automatically expired, and access was rejected with a `403 Forbidden` error.

![Pre-signed URL Created](screenshots/presigned-url-success.png)

\
![Pre-signed URL Expired](screenshots/presigned-url-expired.png)

---

## S3 Security Best Practices Applied

* \[x\] **Block Public Access:** Enabled globally to prevent leaks.

* \[x\] **Least Privilege Policies:** Explicitly denied access to unauthorized users.

* \[x\] **No ACLs:** Relied on IAM and Bucket Policies for cleaner permission management.

* \[x\] **Encrypted Data:** All objects are private by default.

* \[x\] **Auditability:** Access analyzer used to confirm zero public exposure.

---

➡️ Next: [Monitoring & Alerts](../monitoring-logging/cloudwatch.md)
