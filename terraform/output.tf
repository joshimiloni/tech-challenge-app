output "alb_dns_name" {
  description = "URL to access app"
  value       = aws_lb.app.dns_name
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.app.name
}

output "prefix" {
  description = "Application prefix"
  value       = var.prefix
}