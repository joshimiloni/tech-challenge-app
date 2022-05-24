output "alb_dns_name" {
  description = "URL to access app"
  value       = aws_lb.app.dns_name
}

output "app_dns_name" {
  description = "Route53 DNS to access app"
  value       = length(aws_route53_record.app) > 0 ? aws_route53_record.app[0].fqdn : null
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.app.name
}

output "prefix" {
  description = "Application prefix"
  value       = var.prefix
}