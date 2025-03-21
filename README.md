# 🚀 ZSOFTLY Capstone Project: Online Assignment  

## **Project Overview**  
This project deploys a **stateless web application** on **AWS ECS with Fargate**, using **Terraform** for infrastructure automation. It includes:  
✅ A simple Nginx-based web application with two pages  
✅ Docker containerization and hosting on AWS **ECR**  
✅ Deployment using **ECS (Fargate)**  
✅ Load balancing using **ALB (Application Load Balancer)**  
✅ Domain configuration with **Route 53**  
✅ Full Infrastructure as Code (IaC) using **Terraform**  

---

📁 zsoftly-capstone
│-- 📁 web-app              # Web application files (HTML, CSS, Nginx config, Dockerfile)
│   │-- index.html          # Static Page 1
│   │-- page2.html          # Static Page 2
│   │-- nginx.conf          # Nginx configuration
│   │-- Dockerfile          # Dockerfile for building the container
│
│-- 📁 terraform            # Terraform infrastructure code
│   │-- backend.tf          # Terraform backend configuration
│   │-- main.tf             # Main Terraform config (VPC, ECS, Load Balancer, etc.)
│   │-- variables.tf        # Terraform variables
│   │-- outputs.tf          # Terraform outputs
│   │-- 📁 compute          # ECS Task Definition & Service
│   │-- 📁 networking       # VPC, Subnets, ALB, Security Groups
│   │-- 📁 iam              # IAM Roles & Permissions
│
│-- README.md               # Project documentation


---

🛠️  STEP-BY-STEP GUIDE

1️⃣ Set Up the Web Application
Create index.html and page2.html inside web-app/.
Configure nginx.conf for proper routing.
Write a Dockerfile to containerize the application.

2️⃣ Build and Push Docker Image to AWS ECR
# Authenticate Docker with AWS ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.us-east-1.amazonaws.com

# Build the Docker image
docker build -t zsoftly-web-app .

# Tag the Docker image
docker tag zsoftly-web-app:latest <aws_account_id>.dkr.ecr.us-east-1.amazonaws.com/zsoftly-web-app:latest

# Push the image to AWS ECR
docker push <aws_account_id>.dkr.ecr.us-east-1.amazonaws.com/zsoftly-web-app:latest


3️⃣ Deploy Infrastructure Using Terraform
# Navigate to the Terraform directory
cd terraform

# Initialize Terraform
terraform init

# Plan the infrastructure
terraform plan

# Apply the configuration
terraform apply --auto-approve


Once Terraform completes, it will output:

ALB DNS Name
Route 53 DNS Name (if configured)
Open the ALB DNS or Route 53 URL in a browser and test:

http://<alb-dns-name>/page1
http://<alb-dns-name>/page2
✅ Both pages should load successfully!





4️⃣ Testing & Validation
🔹 After deployment, test the application:
✅ Check the Load Balancer DNS to confirm /page1 and /page2 are accessible.
✅ Capture screenshots of successful requests.
✅ Verify logs and monitoring in AWS CloudWatch.


📌 Destroying the Infrastructure
If you no longer need the resources, run:

terraform destroy --auto-approve



📖 Additional Notes
Terraform backend is configured in S3 for state management.
The project uses AWS best practices for security and scalability.
No public Terraform modules—all configurations are built manually.
Re-deploy anytime by running terraform apply.



✅ Final Steps Before Destroying
1️⃣ Push all code to GitHub (git push origin main).
2️⃣ Verify Terraform state is saved (check terraform state list).
3️⃣ Destroy infrastructure (terraform destroy --auto-approve).
4️⃣ Re-deploy later using terraform apply.





