# -----------------------------------------------
# SNS TOPIC FOR BILLING ALERTS
# -----------------------------------------------
resource "aws_sns_topic" "billing_alerts" {
  name = "billing-alerts-tiago"
}

# -----------------------------------------------
# CLOUDWATCH BILLING ALARM
# -----------------------------------------------
resource "aws_cloudwatch_metric_alarm" "billing_alarm" {
  alarm_name          = "BillingAlarm-Under1Dollar"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = 21600 # 6 hours
  statistic           = "Maximum"
  threshold           = 1.00
  alarm_description   = "Alert when estimated charges exceed $1"
  alarm_actions       = [aws_sns_topic.billing_alerts.arn]

  dimensions = {
    Currency = "USD"
  }
}

# -----------------------------------------------
# CLOUDWATCH DASHBOARD
# -----------------------------------------------
resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "CYB310-Security-Dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        properties = {
          title  = "EC2 CPU Utilization"
          metrics = [["AWS/EC2", "CPUUtilization", "InstanceId", aws_instance.linux.id]]
          period = 300
          stat   = "Average"
        }
      },
      {
        type = "metric"
        properties = {
          title  = "Network In/Out"
          metrics = [
            ["AWS/EC2", "NetworkIn",  "InstanceId", aws_instance.linux.id],
            ["AWS/EC2", "NetworkOut", "InstanceId", aws_instance.linux.id]
          ]
          period = 300
          stat   = "Sum"
        }
      },
      {
        type = "metric"
        properties = {
          title  = "EBS Write Bytes"
          metrics = [["AWS/EC2", "EBSWriteBytes", "InstanceId", aws_instance.linux.id]]
          period = 300
          stat   = "Sum"
        }
      }
    ]
  })
}
