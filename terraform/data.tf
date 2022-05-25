data "aws_subnets" "available" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}