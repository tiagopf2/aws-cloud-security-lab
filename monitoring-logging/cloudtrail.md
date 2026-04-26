# CloudTrail Logging & Analysis

## Overview

AWS CloudTrail was used to record and analyze account activity across services. Logs were exported and analyzed to identify user behavior, event types, and potential security risks.

---

## 1\. Event History Tracking

CloudTrail captured management events such as:

* ConsoleLogin

* StartInstances / StopInstances

* CreateBucket

* PutObject

* CreateAccessKey

![CloudTrail Event History](screenshots/cloudtrail-event-history.png)

---

## 2\. Export & Analysis (CSV → Excel)

Event data was downloaded as a CSV file and analyzed in Excel.

### Steps Performed

1. Download event history

2. Import into Excel

3. Convert to sortable table

4. Apply filters on key columns (User name, Event name)

![Excel Raw Data](screenshots/excel-raw.png)

\
![Excel Table](screenshots/excel-table.png)

---

## 3\. Key Findings

### Unique Users

* **12 unique users** identified in the dataset

### Common Event Types

* **ConsoleLogin** → User login activity

* **StartInstances / StopInstances** → EC2 lifecycle operations

* **PutObject** → S3 uploads

* **CreateAnalyzer / CreateConfigRule** → Security service activity

---

## 4\. Security Insights

* Repeated ConsoleLogin events can indicate brute-force attempts

* Frequent Start/StopInstances may signal misuse or automation

* PutObject events help track data uploads to S3

* CreateAccessKey events must be monitored closely (credential risk)

---

## 5\. Why CloudTrail Matters

* Full audit trail of AWS activity

* Supports incident investigation

* Enables compliance and governance

* Detects unauthorized or unusual actions

---

## Key Takeaways

* \\u2705 12 unique users identified and analyzed

* \\u2705 Multiple event types tracked across services

* \\u2705 Logs exported and filtered for pattern detection

* \\u2705 CloudTrail is essential for auditing and forensics

---

\\u27a1\\ufe0f Back to: [CloudWatch](cloudwatch.md)
