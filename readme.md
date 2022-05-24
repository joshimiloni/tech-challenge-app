# Servian DevOps Tech Challenge - Tech Challenge App

## 1. Tech challenge overview
The scope of this challenge is to deploy a simple GTD application backed by a PostgreSQL database into a cloud environment of choice (AWS, Azure, or GCP).

## 2. Solution approach and choice of technologies

### AWS 
AWS will be used used as the cloud provider as it is one of the leading cloud platforms.

### ECS and Fargate
ECS will be used for Docker container orchestration. While I have my expertise in Kubernetes, I will be exploring Fargate to understand more about its of ease of use.

### Terraform
I will experiment with Terraform which provides Infrastructure as a Code. I have recently started exploring Terraform so this challenge will be a good opportunity for me to try  using it to create, manage and also destroy multiple AWS resources.

### RDS
Aurora PostGresSQL will be used to provision the database in two availability zones to achieve high availability as primary and secondary. Aurora is generally preferred for commercial databases where high performance is desired. I have used RDS earlier so want to try using Aurora as part of this challege.

### CodePipeline
Codepipeline will be used for automated deployment with Continuous Integration and Continuous Delivery (CI/CD). GitHub will be used for the source code management and a push to master will trigger CodeBuild. 

### Application Load Balancer (ALB)
ALB will be used for load balancing and auto-scaling.

### High Availability
2 availability zones will be used under the same region. Keeping our resources in more than one zone is important to achieve high availability and to ensure your application is resilient to one zone failure
#### Highly available frontend - Fargate Multi-AZ
#### Auto scaling - Fargate using memory and cpu metrics
 
### Networking/Security (VPC and Subnets)
1 VPC will be created with 1 subnet in each availability zone. 
#### Better security can be achieved using Desired Architecture in next point.

### AWS Identity and Access Management (IAM)
IAM will be used to access control across services and resources of AWS


## 3. High level architecture diagram

### Current Architecture for the scope of this challenge 
![CurrentTechChallengeAppArchitecture.drawio.png](CurrentTechChallengeAppArchitecture.drawio.png)


### Desired Architecture
#### 1. Internet gateway - allow resources in VPC to access internet
#### 2. NAT gateway - allow instances in a private subnet to connect to services outside VPC
#### 3. Public subnet - to deploy NAT gateway and ALB
#### 4. Private subnet - to deploy ECS Fargate and RDS Aurora Database

![DesiredTechChallengeAppArchitecture.drawio.png](DesiredTechChallengeAppArchitecture.drawio.png)

## 4. Pre-requisites

### Pre-requisites

#### 1. Terraform installation 
#### 2. AWS Account and AWS CLI (Basic IAM permissions for ECS, ECR, RDS, ALB etc)
#### 3. Following inputs are required for executing the "terraform apply" command
1. VPC_ID 
While I have mostly used default VPC and subnets as part of my AWS learning journey, this time I tried to create my own VPC and subnets and provide them as inputs.
AWS also has a great feature to create VPC and subnets together by providing count of AZ, public and private subnet 
2. VPC_CIDR
3. PostgreSQL database password

## 5. Deployment steps

###Automated deployment - Github Push action will trigger the Codepipeline
1. Ccode is pushed to master branch

2. CodePipeline gets the code in the Source stage and calls the Build stage (CodeBuild).

3. Build stage will process our Dockerfile and push the Image to ECR followed by triggering the Deploy stage

4. Deploy stage updates our ECS with the new image


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

1. For the scope of this challenge as I was the only one using Terraform to manage AWS resource, terraform.tfstate local updates worked however while working within a team - AWS S3 should be used to maintain state of Terraform to avoid conflicts/data loss.

2. Tests can be added to check success and failure of CodePipeline executions by using AWS Lambda integration.

3. 

4. Checks can be added in Terraform AWS resource configs to prevent deletion based on certain conditions so that terraform destroy does not accidently delete resources.

## 6. Alternatives

1. GitHub actions is another widely used alternative to CodeBuild. 

2. AWS CloudFormation can be used as an alternate to Terraform.