data "aws_subnets" "available" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_route53_zone" "selected" {
  count = var.domain_name == "" ? 0 : 1
  name  = var.domain_name
}