# Servian DevOps Tech Challenge - Tech Challenge App

## 1. Tech challenge overview
The scope of this challenge is to deploy a simple GTD application backed by a PostgreSQL database into a cloud environment of choice (AWS, Azure, or GCP).

## 2. Solution approach and choice of technologies

### AWS 
AWS will be used as the cloud provider as it is one of the leading cloud platforms in the market and I also have some hands-on experience with AWS.

### ECS and Fargate
ECS will be used for Docker contaner orchestration. While I have my expertise in Kubernetes, I am exploring Fargate as part of this challenge to understand more about its benefits in terms of ease of use as it takes away managing the infrastructure and helping us focus on our tasks

### RDS
RDS PostGresSQL will be used to provision the database in two availability zones to achieve high availability. 

### CodePipeline
Codepipeline will be used for automated deployment with Continuous Integration and Continuous Delivery (CI/CD) with its CodeBuild and CodeDeploy feature. GitHub will be used for the source code management. 

### Terraform
I will also be experimenting with usage of Terraform which provides Infrastructure as a Code. I have recently started exploring Terraform so this challenge will be a good place for me to try  using it to create, manage and also destroy AWS resources.

### Application Load Balancer (ALB)
ALB will be used for load balancing and auto-scaling.

### High Availability
We will use 2 availability zones under the same region. Keeping our resources in more than one zone is important to achieve high availability and to ensure your application is resilient to one zone failure
 
### Networking (VPC and Subnets)
1 VPC with 2 subnets will be created in each availability zone.

### AWS Identity and Access Management (IAM)
IAM will be used to access control across services and resources of AWS


## 3. High level architecture diagram

![TechChallengeAppArchitecture.drawio.png](TechChallengeAppArchitecture.drawio.png)

## 4. Deployment steps
###Automated deployment - Github Push action will trigger the Codepipeline

### Manual deployment - Terraform installation is a pre-requisite. 

#### terraform init
Initialize terraform using this command

#### terraform plan
This command will help to understand the execution plan and which AWS resources will be deployed.

#### terraform apply
All AWS resources configured will be provisioned as part of this step

#### terraform destroy
All AWS resources created in previous steps can be destroyed using this command. It is a good practice to delete resources if not in use to avoid additional costs.

## 5. Improvements 

1. GitHub Actions can also be used to automate the application workflow instead of CodeBuild and CodePipeline.

2. Tests can be added to check success and failure of CodePipeline executions