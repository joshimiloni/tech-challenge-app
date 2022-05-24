#ECS cluster
resource "aws_ecs_cluster" "app" {
  name = "${var.prefix}-app"
}

#ECS service using Fargate
resource "aws_ecs_service" "app" {
  name            = "app"
  cluster         = aws_ecs_cluster.app.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = "app"
    container_port   = 3000
  }

  network_configuration {
    subnets          = data.aws_subnets.available.ids
    security_groups  = [aws_security_group.app.id]
    assign_public_ip = var.production ? false : true
  }
}

#ECS task definition with container and database config
resource "aws_ecs_task_definition" "app" {
  family                   = var.prefix
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_tasks_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "app"
      image     = var.container_image
      essential = true
      cpu       = 128
      memory    = 256
      command   = ["serve"]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-region        = "us-east-1"
          awslogs-group         = aws_cloudwatch_log_group.default.name
          awslogs-stream-prefix = "app"
        }
      }
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
      environment = [
        {
          name  = "VTT_DBHOST"
          value = aws_rds_cluster.postgres.endpoint
        },
        {
          name  = "VTT_DBPASSWORD"
          value = var.postgresql_password
        },
        {
          name  = "VTT_LISTENHOST"
          value = "0.0.0.0"
        }
      ]
    }
  ])
}
