resource "aws_route53_record" "app" {
  count   = var.domain_name == "" ? 0 : 1
  zone_id = data.aws_route53_zone.selected[0].zone_id
  name    = var.prefix
  type    = "CNAME"
  ttl     = "300"
  records = [aws_lb.app.dns_name]
}