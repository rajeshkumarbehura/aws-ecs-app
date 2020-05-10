# logs.tf
# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "webcore_log_group" {
  name              = "/ecs/webcore"
  retention_in_days = 30

  tags = {
    Name = "webcore-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "cb_log_stream" {
  name           = "webcore-log-stream"
  log_group_name = aws_cloudwatch_log_group.webcore_log_group.name
}
