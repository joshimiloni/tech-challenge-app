variable "prefix" {
  description = "For consisent resource naming"
  default     = "servian-tech-challenge"
}

variable "container_image" {
  description = "Docker image"
  default     = "servian/techchallengeapp:latest"
}

variable "vpc_id" {
  description = "VPC"
  default = "arn:aws:secretsmanager:us-east-1:551590290388:secret:vpc_id-NqbvYt"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
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
  default = "arn:aws:secretsmanager:us-east-1:551590290388:secret:postgresql_password-ssIHj5"
  sensitive   = true
}

variable "postgresql_instance_class" {
  description = "PostgreSQL database instance class"
  default     = "db.t3.medium"
}

