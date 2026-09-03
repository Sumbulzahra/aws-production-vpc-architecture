# AWS Production VPC Architecture with Bastion Host & Private Subnets

A secure, scalable, and production-grade Virtual Private Cloud (VPC) architecture built on Amazon Web Services (AWS). This project implements a multi-tier network topology utilizing public and private subnets, an internet gateway, a NAT gateway, an Application Load Balancer (ALB), and a Bastion Host (Jump Server) for secure administrative access.

---

## 🏗️ Architecture Overview

The architecture is designed with high security and isolation in mind, separating public-facing resources from backend application servers.

* **VPC Name:** `aws-prod-example`
* **IPv4 CIDR:** Default
* **Availability Zones (AZs):** 2 (e.g., `us-east-1a`, `us-east-1b`)
* **Public Subnets:** 2 (Hosted with public routing and Internet Gateway access)
* **Private Subnets:** 2 (Isolated backend subnets with outbound access via NAT Gateway)
* **NAT Gateway:** 1 per AZ (ensuring high availability and private instance updates)
* **VPC Endpoints:** None

---

## 🛠️ Components & Configuration

### 1. Launch Template & Auto Scaling Group (ASG)
* **Launch Template Name:** `aws-prod-example`
* **AMI:** Ubuntu
* **Instance Type:** `t2.micro` (Free Tier eligible)
* **Security Group Rules:**
  * **SSH (Port 22):** Source restricted to the Bastion Host.
  * **Custom TCP (Port 8000):** Source allowed from the Application Load Balancer target group.

### 2. Bastion Host (Jump Server Setup)
A Bastion Host is deployed in the public subnet to allow secure administrative SSH access to instances residing in the private subnets.
* **Name:** `bastion-host`
* **AMI:** Ubuntu (`t2.micro`)
* **Network:** Placed in a Public Subnet with Public IP enabled.
* **Security Group:** Allows inbound SSH (Port 22) from your local machine IP (`0.0.0.0/0` or restricted to your specific IP).

### 3. Application Load Balancer (ALB) & Target Group
* **Type:** Application Load Balancer (Internet-facing)
* **VPC & Subnets:** Custom VPC with both Public Subnets selected.
* **Listeners & Routing:** Route incoming traffic on Port 80 to the backend target group listening on Port 8000.
* **Target Group:**
  * **Target Type:** Instances
  * **Protocol:** HTTP, **Port:** 8000
  * **VPC:** Custom VPC selected
  * **Targets:** Private instances registered dynamically.

---

## 🚀 Deployment & Configuration Steps

### Step 1: Connecting to the Private Instance via Bastion Host
To connect to your private instance securely, use your SSH key and the Bastion Host as an intermediate jump box:

1. **Copy your private key (`.pem`) to the Bastion Host from your local machine:**
   ```bash
   scp -i "aws-login.pem" aws-login.pem ubuntu@<BASTION_PUBLIC_IP>:/home/ubuntu/

```

2. **SSH into the Bastion Host, then hop into the Private Instance:**
```bash
ssh -i "aws-login.pem" ubuntu@<PRIVATE_INSTANCE_IP>

```



### Step 2: Sample Application Deployment (Private Instance Script)

During instance initialization, the automated script (`scripts/Sample-Application-Deployment-(Private-Instance).sh`) executes the following commands to spin up a lightweight Python HTTP server displaying an HTML landing page:

```bash
# Create index.html file
cat <<EOF> index.html
<!DOCTYPE html>
<html>
<body>
<h1>My First AWS Project</h1>
<p>To demonstrate apps in private subnet</p>
</body>
</html>
EOF

# Run Python web server on port 8000 in the background
python3 -m http.server 8000

```

---

## 📂 Repository Structure

```text
aws-production-vpc-architecture/
├── scripts/
│   └── Sample-Application-Deployment-(Private-Instance).sh
├── architecture/
│   └── vpc-example-private-subnets.png
└── README.md

```

---

## 🤝 Author & Connect

* **Sumbul Zahra**
* **LinkedIn:** [View my LinkedIn Post/Profile](https://www.google.com/search?q=https://https://lnkd.in/p/dRpj26-j)
