#ALB
resource "aws_lb" "app" {
  name               = "${var.prefix}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = data.aws_subnets.available.ids
}

#ALB target group
resource "aws_lb_target_group" "app" {
  name        = "${var.prefix}-tg"
  port        = 3000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path = "/healthcheck"
  }
}

#ALB listener on 80
resource "aws_lb_listener" "app_80" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

#ALB security group for inboud traffic on port 80
resource "aws_security_group" "lb_sg" {
  name        = "${var.prefix}-lb-sg"
  description = "Allow external connections on url"
  vpc_id      = var.vpc_id

  ingress = [
    {
      description      = "port 80 "
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      security_groups  = []
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      self             = false
    }
  ]

  egress = [
    {
      description      = "allowing healthcheck access"
      from_port        = 3000
      to_port          = 3000
      protocol         = "tcp"
      cidr_blocks      = ["172.31.0.0/16"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "${var.prefix}-lb-sg"
  }
}

#Inbound connections on port 3000 from LB and Outbound anywhere
resource "aws_security_group" "app" {
  name        = "${var.prefix}-server"
  description = "Allow connections from the LB"
  vpc_id      = var.vpc_id

  ingress = [
    {
      description      = "port 3000 from load balancer"
      from_port        = 3000
      to_port          = 3000
      protocol         = "tcp"
      cidr_blocks      = []
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = [aws_security_group.lb_sg.id]
      self             = false
    }
  ]

  egress = [
    {
      description      = "allowing internet access"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "${var.prefix}-server"
  }
}
