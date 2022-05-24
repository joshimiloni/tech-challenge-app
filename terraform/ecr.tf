#ECR repository to store our Docker image - servian/techchallengeapp:latest
resource "aws_ecr_repository" "tech_app_repository" {
  name = "tech_app_repository"
}