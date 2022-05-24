variable "prefix" {
  description = "For consisent resource naming"
  default     = "servian-tech-challenge"
}

variable "container_image" {
  description = "Docker image"
  default     = "servian/techchallengeapp:latest"
}

variable "vpc_id" {
  description = "VPC to deploy application stack"
}

variable "azs" {
  type = list(string)
  default = [
    "us-east-1a",
    "us-east-1b"
  ]
}

variable "domain_name" {
  description = "Domain name of a hosted Route53 zone"
  default     = "servian-tech-challenge.com"
}

variable "postgresql_version" {
  description = "PostgreSQL version"
  default     = "10.17"
}

variable "postgresql_password" {
  description = "PostgreSQL database password"
  sensitive   = true
}

variable "postgresql_instance_class" {
  description = "PostgreSQL database instance class"
  default     = "db.t3.medium"
}

