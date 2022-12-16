resource "aws_lb_target_group" "kodespace-app" {
  name        = "kodespace-app"
  port        = 5000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.app_vpc.id

  health_check {
    enabled = true
    path    = "/health"
  }

  depends_on = [aws_alb.kodespace_app]
}

resource "aws_alb" "kodespace_app" {
  name               = "kodespace-lb"
  internal           = false
  load_balancer_type = "application"

  subnets = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id,
  ]

  security_groups = [
    aws_security_group.http.id,
  ]

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_alb_listener" "kodespace_app_listener" {
  load_balancer_arn = aws_alb.kodespace_app.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.kodespace-app.arn
  }
}

output "alb_kodespace" {
  value = "http://${aws_alb.kodespace_app.dns_name}"
}
