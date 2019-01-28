# -- PROD --
resource "aws_cloudwatch_log_group" "myapp" {
  name              = "/ecs/myapp"
  retention_in_days = 30
  tags {
    Name = "myapp"
  }
}

# -- DEV --
resource "aws_cloudwatch_log_group" "myapp_dev" {
  name              = "/ecs/myapp_dev"
  retention_in_days = 30
  tags {
    Name = "myapp_dev"
  }
}
