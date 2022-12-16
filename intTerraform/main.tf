provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "us-east-1"

}

# Cluster
resource "aws_ecs_cluster" "aws-ecs-cluster" {
  name = "kodespaceapp-cluster"
  tags = {
    Name = "kodespace-ecs"
  }
}

resource "aws_cloudwatch_log_group" "log-group" {
  name = "/ecs/kodespace-logs"

  tags = {
    Application = "kodespace-app"
  }
}

# Task Definition

resource "aws_ecs_task_definition" "aws-ecs-task" {
  family = "kodespace-task"

  container_definitions = <<EOF
  [
    {
      "name": "kodespace-container",
      "image": "kodespace01/kodespace-website:latest",
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/kodespace-logs",
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
  execution_role_arn       = "arn:aws:iam::928847339565:role/ecstask"
  task_role_arn            = "arn:aws:iam::928847339565:role/ecstask"

}

# ECS Service
resource "aws_ecs_service" "aws-ecs-service" {
  name                 = "kodespace-ecs-service"
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
    target_group_arn = aws_lb_target_group.kodespace-app.arn
    container_name   = "kodespace-container"
    container_port   = 5000
  }

}

