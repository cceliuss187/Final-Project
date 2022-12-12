provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "us-east-1"

}

# Cluster
resource "aws_ecs_cluster" "aws-ecs-cluster" {
  name = "kodeSPACEapp-cluster"
  tags = {
    Name = "kodeSPACE-ecs"
  }
}

resource "aws_cloudwatch_log_group" "log-group" {
  name = "/ecs/kodeSPACE-logs"

  tags = {
    Application = "kodeSPACE-app"
  }
}

# Task Definition

resource "aws_ecs_task_definition" "aws-ecs-task" {
  family = "kodeSPACE-task"

  container_definitions = <<EOF
  [
  {
      "name": "KodeSPACE-container",
      "image": "KodeSPACE01/kodespace01:kodespace",
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/kodeSPACE-logs",
          "awslogs-region": "us-east-1",
          "awslogs-stream-prefix": "ecs"
        }
      },
      "portMappings": [
        {
          "containerPort": 5000
        }
      ]
    }
  ]
  EOF

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "1024"
  cpu                      = "512"
  execution_role_arn       = "arn:aws:iam::928847339565:role/ECS_Full1"
  task_role_arn            = "arn:aws:iam::928847339565:role/ECS_Full1"

}

# ECS Service
resource "aws_ecs_service" "aws-ecs-service" {
  name                 = "kodeSPACE-ecs-service"
  cluster              = aws_ecs_cluster.aws-ecs-cluster.id
  task_definition      = aws_ecs_task_definition.aws-ecs-task.arn
  launch_type          = "FARGATE"
  scheduling_strategy  = "REPLICA"
  desired_count        = 1
  force_new_deployment = true

  network_configuration {
    subnets = [
      aws_subnet.private_a.id,
      aws_subnet.private_b.id
    ]
    assign_public_ip = false
    security_groups  = [aws_security_group.ingress_app.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.kodeSPACE-app.arn
    container_name   = "KodeSPACE-container"
    container_port   = 5000
  }

}
