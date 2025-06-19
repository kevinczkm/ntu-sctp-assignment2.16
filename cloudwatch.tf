provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_cloudwatch_metric_alarm" "kvin_info_count_breach" {
  alarm_name                = "kvin-info-count-breach"
  namespace                 = "/moviedb-api/kevinczkm"
  metric_name               = "info-count"
  statistic                 = "Sum"
  period                    = 60                          # 1 minute
  evaluation_periods        = 1
  datapoints_to_alarm       = 1
  threshold                 = 10
  comparison_operator       = "GreaterThanThreshold"
  treat_missing_data        = "missing"
  actions_enabled           = true

  alarm_actions = [aws_sns_topic.alerts.arn]

  alarm_description         = "Alarm triggers if info-count > 10 within 1 minute"
}

resource "aws_sns_topic" "alerts" {
  name = "my-sns-topic"
}

resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = "your-email@example.com"  # You'll get a confirmation email
}
