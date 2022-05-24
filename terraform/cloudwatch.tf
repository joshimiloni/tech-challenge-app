#CloudWatch logs from ECS container
resource "aws_cloudwatch_log_group" "default" {
  name= "/ecs/${var.prefix}"
  retention_in_days = 7
}