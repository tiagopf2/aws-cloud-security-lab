# CloudWatch Monitoring & Alerts

## Overview

Amazon CloudWatch was used to monitor system performance, detect anomalies, and control costs. Dashboards and alarms provide real-time visibility into EC2 activity and account usage.

---

## 1\. Billing Alarm

A billing alarm was configured to prevent unexpected costs.

* **Metric:** EstimatedCharges (AWS/Billing)

* **Threshold:** < $1

* **Period:** 6 hours

* **Action:** SNS notification

![Billing Alarm](screenshots/cloudwatch-billing-alarm.png)

> This ensures early detection of abnormal spending or misconfigured resources.

---

## 2\. Custom Dashboard

A CloudWatch dashboard was created to visualize system metrics.

### Metrics Included

* CPU Utilization

* Network In / Out

* EBS Write Bytes

* Volume Write Bytes

* API Call Count

![CloudWatch Dashboard](screenshots/cloudwatch-dashboard.png)

---

## 3\. Detailed Monitoring

Detailed monitoring was enabled for EC2 instances to collect data at **1-minute intervals** instead of 5 minutes.

![Detailed Monitoring](screenshots/detailed-monitoring.png)

> Provides higher resolution data for detecting short-lived spikes or anomalies.

---

## 4\. Key Visualizations

### Network Traffic

* Helps detect unusual spikes (possible DDoS or exfiltration)

![Network In/Out](screenshots/network-metrics.png)

### Storage Metrics

* Identifies disk usage and performance bottlenecks

![EBS Metrics](screenshots/ebs-metrics.png)

### API Call Activity

* Tracks AWS service usage patterns

![Call Count](screenshots/api-callcount.png)

---

## Security Value

* Detect abnormal behavior (traffic spikes, CPU abuse)

* Monitor system health in real time

* Prevent unexpected billing issues

* Provide visibility for incident response

---

## Key Takeaways

* ✅ Billing alarms prevent cost overruns

* ✅ Dashboards provide centralized monitoring

* ✅ Detailed monitoring improves detection accuracy

* ✅ Metrics help identify suspicious activity early

---

➡️ Next: [CloudTrail Logging](cloudtrail.md)
