# Capstone Assignment — Deploy the Book Review App Using Terraform and Claude Code Agentic AI

Part of the DevOps Micro Internship (DMI) Cohort 3 with Agentic AI

---

## Student Details

**Full Name:** Saima Usman  
**Cloud Platform:** AWS
**GitHub Repository URL:** https://github.com/Saima-Devops/book-review-capstone.git  
**Public Application URL / Load-Balancer DNS:** `http://book-review-dev-public-alb-1740401681.us-east-1.elb.amazonaws.com`

---

## Purpose

Deploy the Book Review App using Terraform on AWS or Azure in a secure, highly available, production-style three-tier architecture. Use Claude Code, specialized subagents, Terraform MCP, and validation hooks to support the engineering workflow while keeping all infrastructure-changing operations under human control.

---

## Overall Architecture
```

                         INTERNET
                            │
                            ▼
                 ┌─────────────────────┐
                 │ Public Application   │
                 │ Load Balancer (ALB)  │
                 └──────────┬──────────┘
                            │
                 ┌──────────▼──────────┐
                 │     WEB TIER        │
                 │   Next.js + Nginx   │
                 │   Public Subnets    │
                 └──────────┬──────────┘
                            │
                            ▼
                 ┌─────────────────────┐
                 │ Internal Application│
                 │    Load Balancer    │
                 └──────────┬──────────┘
                            │
                 ┌──────────▼──────────┐
                 │ APPLICATION TIER    │
                 │ Node.js / Express   │
                 │ Private Subnets     │
                 │      Port 3001      │
                 └──────────┬──────────┘
                            │
                            ▼
                 ┌─────────────────────┐
                 │    DATABASE TIER    │
                 │    RDS MySQL        │
                 │    Private Subnets  │
                 │      Port 3306      │
                 └─────────────────────┘
```

## AWS Network - Subnets Requirements

```
VPC
10.0.0.0/16

AZ-A                         AZ-B
────────────────────         ────────────────────
Public Web                   Public Web
10.0.1.0/24                  10.0.2.0/24

Private App                  Private App
10.0.11.0/24                 10.0.12.0/24

Private DB                   Private DB
10.0.21.0/24                 10.0.22.0/24

```

## Important Security Posture

```
Internet
   │
   │ 80/443
   ▼
Public ALB
   │
   ▼
Web EC2
   │
   │ 3001
   ▼
Internal ALB
   │
   ▼
Backend EC2
   │
   │ 3306
   ▼
RDS MySQL

```
---

# Task 0 — Prepare the Project and Agentic AI Environment

## Goal

Prepare the Book Review App project and configure the provided Claude Code Agentic AI starter kit with project context, specialized subagents, Terraform MCP, validation hooks, and safety guardrails.

## Evidence

### Screenshot 1 — Project `CLAUDE.md`

Add a screenshot of the project `CLAUDE.md` showing the three-tier architecture, security boundaries, Terraform requirements, and human-approval rules.

![alt text](screenshots/week08-asnmnt-05-1.png)

![alt text](screenshots/week08-asnmnt-05-2.png)

![alt text](screenshots/week08-asnmnt-05-3.png)

---

### Screenshot 2 — Terraform Engineer Subagent

Add a screenshot showing the Terraform Engineer subagent configuration.

![alt text](screenshots/week08-asnmnt-05-4.png)

---

### Screenshot 3 — Architecture and Security Reviewer Subagent

Add a screenshot showing the Architecture and Security Reviewer subagent configuration.

![alt text](screenshots/week08-asnmnt-05-9.png)

---

### Screenshot 4 — Terraform MCP Connection

Add a screenshot showing Terraform MCP connected and available.

![alt text](screenshots/week08-asnmnt-05-10.png)

---

### Screenshot 5 — Validation Hooks

Add a screenshot showing the configured Claude Code validation hooks.

![alt text](screenshots/week08-asnmnt-05-11.png)

---

# Task 1 — Design the Three-Tier Architecture

## Goal

Design the required secure, highly available three-tier architecture and create an architecture diagram before building the infrastructure.

The diagram must show:

- VPC or VNet
- Availability Zones or equivalent availability locations
- Six subnets
- Internet connectivity
- NAT or outbound design
- Public load balancer
- Web Tier
- Internal load balancer
- Application Tier
- Managed MySQL
- Read replica
- Main traffic flow

## Architecture Diagram

![alt text](screenshots/Architecture-Diagram.png)

```    
                         INTERNET
                            │
                            ▼
                  ┌──────────────────┐
                  │   PUBLIC ALB     │
                  │ Internet-facing  │
                  └────────┬─────────┘
                           │
                ┌──────────┴──────────┐
                ▼                     ▼
          ┌───────────┐         ┌───────────┐
          │ Web EC2 A │         │ Web EC2 B │
          │  Next.js  │         │  Next.js  │
          └─────┬─────┘         └─────┬─────┘
                │                     │
                └──────────┬──────────┘
                           ▼
                  ┌──────────────────┐
                  │  INTERNAL ALB    │
                  │    PRIVATE       │
                  └────────┬─────────┘
                           │ :3001
                ┌──────────┴──────────┐
                ▼                     ▼
          ┌───────────┐         ┌───────────┐
          │ App EC2 A │         │ App EC2 B │
          │ Node/Exp. │         │ Node/Exp. │
          └─────┬─────┘         └─────┬─────┘
                │                     │
                └──────────┬──────────┘
                           │ :3306
                           ▼
                  ┌──────────────────┐
                  │   RDS MySQL      │
                  │   Multi-AZ       │
                  └────────┬─────────┘
                           │
                           ▼
                    ┌─────────────┐
                    │ Read Replica│
                    └─────────────┘

```

**Inside:**

```
AWS us-east-1
└── VPC 10.0.0.0/16
    │
    ├── us-east-1a
    │   ├── Web 10.0.1.0/24   PUBLIC
    │   ├── App 10.0.11.0/24  PRIVATE
    │   └── DB  10.0.21.0/24  PRIVATE
    │
    └── us-east-1b
        ├── Web 10.0.2.0/24   PUBLIC
        ├── App 10.0.12.0/24  PRIVATE
        └── DB  10.0.22.0/24  PRIVATE

```

**with:**

```
Internet → Web
Web → App : 3001
App → DB : 3306

```

---

# Task 2 — Build the Terraform Networking and Security Layers

## Goal

Create the modular Terraform project and implement the network and security layers across the required public and private subnets.

## Evidence

### Screenshot 6 — Modular Terraform Project Structure

Add a screenshot showing the modular Terraform project structure.

![alt text](screenshots/week08-asnmnt-05-8.png)

![alt text](<screenshots/terraform structure.png>)

---

### Screenshot 7 — Six-Subnet Architecture

Add a screenshot showing the six-subnet architecture across two availability locations.

![alt text](screenshots/screenshot-7.png)

![alt text](screenshots/screenshot-8.png)

---

### Screenshot 8 — Public and Private Tier Separation

Add a screenshot showing the public and private tier separation, including routing and security boundaries.

![alt text](screenshots/screenshot-9.png)

![alt text](screenshots/screenshot-9b.png)

---

# Task 3 — Build the Load-Balancing and Compute Layers

## Goal

Deploy the public and internal load balancers and the Web and Application compute resources required by the Book Review App.

## Evidence

### Screenshot 9 — Web and Application Compute

Add a screenshot showing the Web and Application compute resources in their required subnets.

![alt text](screenshots/ec2.png)

---

### Screenshot 10 — Public Load Balancer

Add a screenshot showing the internet-facing public load balancer.

![alt text](screenshots/loadbalancers.png)
![alt text](screenshots/loadbalancers-2.png)

---

### Screenshot 11 — Internal Load Balancer

Add a screenshot showing the private internal load balancer.

![alt text](screenshots/loadbalancers-3.png)

---

### Screenshot 12 — Healthy Targets

Add a screenshot showing healthy target groups or backend pools.

![alt text](screenshots/healthy-targets-1.png)

![alt text](screenshots/healthy-targets-2.png)

---

# Task 4 — Build the Managed MySQL Database Layer

## Goal

Deploy a private, highly available managed MySQL database with a read replica and restrict database connectivity to the Application Tier.

## Evidence

### Screenshot 13 — Managed MySQL Database

Add a screenshot showing the managed MySQL database deployment.

![alt text](screenshots/databases.png)

---

### Screenshot 14 — High Availability

Add a screenshot showing the Multi-AZ or high-availability configuration.

![alt text](screenshots/security-groups.png)

---

### Screenshot 15 — Read Replica

Add a screenshot showing the read replica configuration.

![alt text](screenshots/databases-2.png)

---

### Screenshot 16 — Private Database Access

Add a screenshot showing that the database is private and accepts MySQL traffic only from the Application Tier.

![alt text](screenshots/loadbalancers-3.png)

---

# Task 5 — Validate, Review, and Apply the Terraform Configuration

## Goal

Validate the Terraform configuration, review the execution plan using both Agentic AI and human judgment, and apply the infrastructure changes only after all required checks pass.

## Evidence

### Screenshot 17 — Terraform Validation

Add a screenshot showing successful `terraform validate` output.

![alt text](screenshots/terraform-validate-1.png)

![alt text](screenshots/terraform-validate-2.png)

---

### Screenshot 18 — Terraform Plan

Add a screenshot showing the Terraform plan output.

![alt text](screenshots/week08-asnmnt-04-18.png)

---

### Screenshot 19 — Terraform Apply

Add a screenshot showing successful `terraform apply` completion.

![alt text](screenshots/terraform-apply.png)

---

# Task 6 — Deploy and Configure the Book Review Application

## Goal

Deploy and configure the Book Review App across the Web, Application, and Database tiers and verify the complete application functionality.

## Evidence

### Screenshot 20 — Homepage

Add a screenshot showing the Book Review App homepage through the public endpoint.

![alt text](screenshots/screenshot-final-1.png)

---

### Screenshot 21 — Login or Authentication

Add a screenshot showing successful login or authentication.

![alt text](screenshots/screenshot-final-2.png)

![alt text](screenshots/screenshot-final-3.png)

---

### Screenshot 22 — Book Data

Add a screenshot showing the book listing or book details.

![alt text](screenshots/screenshot-final-4.png)

---

### Screenshot 23 — Review Functionality

Add a screenshot showing the review functionality working successfully.

![alt text](screenshots/screenshot-final-5.png)

---

### Screenshot 24 — Backend or API Evidence

Add a screenshot showing that the backend or API is working successfully.

![alt text](screenshots/api-endpoint.png)

---

### Screenshot 25 — Database Reads and Writes

Add a screenshot showing successful database reads and writes.

![alt text](screenshots/screenshot-final-5.png)

## Public Application URL

**Public Application URL / DNS:** `http://book-review-dev-public-alb-1740401681.us-east-1.elb.amazonaws.com`

---

# Task 7 — Demonstrate the Agentic AI Workflow

## Goal

Demonstrate how Claude Code assisted with Terraform generation, architecture and security review, and evidence-based troubleshooting while infrastructure-changing decisions remained under human control.

You do not need to submit your complete Claude Code conversation history. Include only focused evidence.

## Evidence

### Screenshot 26 — AI-Assisted Terraform Generation

Add a screenshot showing one useful example of AI-assisted Terraform generation or improvement.

![alt text](<screenshots/Screenshot 26.png>)

---

### Screenshot 27 — Architecture or Security Review

Add a screenshot showing one structured architecture or security review result.

![alt text](<screenshots/Screenshot 27-a.png>)

![alt text](<screenshots/Screenshot 27-b.png>)

![alt text](<screenshots/Screenshot 27-c.png>)

**Screenshot 27** — Architecture and Security Review: Claude Code's specialized Architecture/Security Reviewer performed a structured review of tier separation, network exposure, security-group rules, load balancing, database privacy, Terraform quality, reliability, and cost risks. Findings were reviewed before deployment.


---

### Screenshot 28 — AI-Assisted Troubleshooting

Add a screenshot showing one AI-assisted troubleshooting interaction based on collected evidence.

![alt text](<screenshots/Screenshot 28-a.png>)

![alt text](<screenshots/Screenshot 28-b.png>)

**Screenshot 28** — AI-Assisted Troubleshooting: Claude Code analyzed collected ALB target-health, SSM, PM2, and backend-log evidence to identify the root cause of failed Application Tier health checks. The issue was verified as an empty DB_HOST in the App runtime environment, corrected through a controlled SSM-based change, and retested successfully.

---

# Task 8 — Complete the Final Architecture Review

## Goal

Review the completed infrastructure against the original capstone requirements and resolve significant architecture, security, reliability, and cost issues.

Confirm that the final review covers:

- Tier separation
- Availability
- Public exposure
- Routing
- Security rules
- Load balancing
- Database privacy
- Secrets
- Terraform quality
- Module structure
- Reliability
- Obvious cost risks

Use Screenshot 27 as the focused evidence for the structured architecture or security review.

---

# Task 9 — Answer the Reflection Questions

## Goal

Reflect on the architecture, Terraform implementation, and Agentic AI workflow. Answer each question briefly in your own words.

## Architecture

### 1. Why did you separate the Web, Application, and Database tiers?

I separated the infrastructure into three tiers to improve security, scalability, and maintainability. The Web tier handles user traffic, the Application tier runs the backend logic, and the Database tier stores application data.

### 2. Why is the Application Tier private?

The Application Tier is private so users cannot directly access the backend servers from the internet. Traffic reaches the application through the internal load-balancing layer, reducing the attack surface.

### 3. Why is MySQL private?

MySQL is private because the database should only be accessible by the Application Tier. This prevents direct internet access to the database and protects sensitive application data.

### 4. Why are multiple Availability Zones used?

Multiple Availability Zones improve high availability and fault tolerance. If one Availability Zone has a failure, resources in another zone can continue serving the application.

### 5. What is the difference between Multi-AZ/high availability and a read replica?

Multi-AZ is mainly for high availability and failover, while a read replica is mainly used to offload read traffic and improve read scalability. A read replica is not a replacement for Multi-AZ failover.

## Terraform

### 6. How did you divide your Terraform into modules?

I divided Terraform into reusable modules for network, security, load balancer, compute, and database. This keeps the infrastructure organized and makes individual components easier to manage and reuse.

### 7. How do the modules communicate through variables and outputs?

Modules receive configuration through variables and expose important resource information through outputs. The root module passes values between modules, such as subnet IDs, security group IDs, and load balancer information.

### 8. What did you specifically check in `terraform plan`?

I checked which resources Terraform planned to create, change, or destroy. I also reviewed security groups, networking, instance configuration, load balancers, and database changes to make sure there were no unexpected or destructive changes.

## Agentic AI

### 9. What was the purpose of `CLAUDE.md`?

`CLAUDE.md` provided Claude with the project context, architecture, workflow, safety rules, and output requirements. It helped Claude understand how to work with the Terraform project consistently and safely.

### 10. What work did the Terraform Engineer subagent perform?

The Terraform Engineer subagent helped analyze the Terraform implementation, review the infrastructure configuration, identify issues, and suggest appropriate Terraform changes while following the project requirements.

### 11. What did the Architecture and Security Reviewer identify?

The Architecture and Security Reviewer examined the infrastructure from a security and architecture perspective, checking areas such as network separation, private resources, security-group access, and overall architecture risks.

### 12. Why did you use Terraform MCP instead of relying only on Claude's existing Terraform knowledge?

Terraform MCP provides Claude with project-specific Terraform tooling and context instead of relying only on general knowledge. This makes Terraform analysis more grounded in the actual project and helps reduce assumptions.

### 13. What was the purpose of your validation hooks?

The validation hooks automatically ran Terraform formatting and validation after Terraform files were edited. They helped catch configuration or syntax problems early and maintain a valid Terraform configuration.

### 14. Describe one real issue Claude helped you troubleshoot.

Claude helped troubleshoot the Application Tier deployment/runtime issue, where the backend targets were not becoming healthy because the required runtime environment configuration was not available correctly. Claude helped trace the issue and identify the configuration problem so the application targets could become healthy.

### 15. Describe one recommendation you reviewed, modified, or rejected instead of accepting blindly.

I reviewed Claude's proposed changes before applying them instead of accepting them automatically. For example, during the drift exercise I reviewed the controlled `Tier = "web-drift-test"` change and confirmed through Terraform plan that it affected only the intended EC2 tags, with no unexpected resource replacement or destruction.

---

# Task 10 — Publish the Mandatory LinkedIn Post

## Goal

Publish a LinkedIn post describing the capstone, the technical work completed, the Agentic AI workflow, and the lessons learned.

Write the post in your own words, include at least one project image or other proof, and ensure that it can be viewed by the submission reviewer.

## LinkedIn Post URL

**LinkedIn Post URL:** https://www.linkedin.com/posts/saima-usman_devops-terraform-aws-activity-7502085996671594496-M-lD?utm_source=share&utm_medium=member_desktop&rcm=ACoAABsfrYoBkq_t-PkQCt7fEB9Ajmp98YTHl_g

---

# Submission Instructions

- Complete Tasks 0–10 in sequence.
- Include all Screenshots 1–28 exactly as specified.
- Ensure that your full name is visible in the required screenshots.
- Include the selected cloud platform.
- Include the completed architecture diagram.
- Include the modular Terraform project structure.
- Include the working public application URL or public load-balancer DNS.
- Include all required Agentic AI workflow evidence.
- Answer all 15 reflection questions briefly in your own words.
- Include the published LinkedIn post URL.
- Do not expose cloud credentials, database passwords, SSH private keys, JWT secrets, access tokens, account IDs, Terraform state containing sensitive values, or other confidential information.
- Review all screenshots and project files carefully before submitting through GitHub.

---

# Completion Checklist

- [✅] Selected AWS or Azure
- [✅] Added and reviewed the Agentic AI starter files
- [✅] Configured `CLAUDE.md`
- [✅] Configured the Terraform Engineer subagent
- [✅] Configured the Architecture and Security Reviewer subagent
- [✅] Connected Terraform MCP
- [✅] Configured validation hooks and safety guardrails
- [✅] Created the architecture diagram
- [✅] Created the six-subnet design
- [✅] Configured public Web Tier routing
- [✅] Kept the Application Tier private
- [✅] Kept the Database Tier private
- [✅] Configured tier-specific Security Groups or NSGs
- [✅] Restricted backend port `3001`
- [✅] Restricted MySQL port `3306` to the Application Tier
- [✅] Created the public load balancer
- [✅] Created the internal load balancer
- [✅] Configured listeners and health checks
- [✅] Deployed the Web Tier compute resources
- [✅] Deployed the private Application Tier compute resources
- [✅] Provisioned private managed MySQL
- [✅] Configured Multi-AZ or high availability
- [✅] Configured a read replica
- [✅] Created the modular Terraform project
- [✅] Used variables, outputs, and module dependencies
- [✅] Used current Terraform documentation through MCP
- [✅] Used hooks for deterministic validation
- [✅] Completed `terraform fmt`
- [✅] Completed `terraform validate`
- [✅] Reviewed `terraform plan`
- [✅] Completed the Terraform Engineer review
- [✅] Completed the Architecture and Security review
- [✅] Applied the infrastructure only after human approval
- [✅] Deployed and configured the backend
- [✅] Deployed and configured the frontend
- [✅] Configured Nginx where required
- [✅] Configured the internal backend endpoint
- [✅] Configured the public frontend endpoint
- [✅] Verified the homepage
- [✅] Verified login or authentication
- [✅] Verified book data
- [✅] Verified review functionality
- [✅] Verified the backend API
- [✅] Verified database reads and writes
- [✅] Verified healthy load-balancer targets
- [✅] Included AI-assisted Terraform generation evidence
- [✅] Included one architecture or security review
- [✅] Included one AI-assisted troubleshooting example
- [✅] Completed the final architecture review
- [✅] Answered all 15 reflection questions
- [✅] Published the mandatory LinkedIn post
- [✅] Added the LinkedIn post URL
- [✅] Captured all 28 required screenshots
- [✅] Confirmed that my full name is visible in the required screenshots
- [✅] Checked that no secrets or sensitive information are exposed

---

## About DMI & CloudAdvisory

DevOps Micro Internship (DMI) is a project-based DevOps program run by Pravin Mishra (The CloudAdvisory), focused on real-world execution, systems thinking, and career readiness.

It helps learners build strong DevOps foundations through hands-on experience.

---

## Resources

- Book Review App Repository: [https://github.com/pravinmishraaws/book-review-app](https://github.com/pravinmishraaws/book-review-app)
- DMI Official Website: [https://dmi.pravinmishra.com](https://dmi.pravinmishra.com)
- University: [https://university.pravinmishra.com](https://university.pravinmishra.com)
- Discord Community: [https://discord.pravinmishra.com](https://discord.pravinmishra.com)
- Blog: [https://dmi.pravinmishra.com/blog](https://dmi.pravinmishra.com/blog)
- YouTube Playlist: [https://www.youtube.com/playlist?list=PLFeSNDtI4Cho](https://www.youtube.com/playlist?list=PLFeSNDtI4Cho)
- Pravin Mishra on LinkedIn: [https://www.linkedin.com/in/pravin-mishra-aws-trainer/](https://www.linkedin.com/in/pravin-mishra-aws-trainer/)
- CloudAdvisory on LinkedIn: [https://www.linkedin.com/company/thecloudadvisory/](https://www.linkedin.com/company/thecloudadvisory/)

---

*This submission is part of the DevOps Micro Internship (DMI) Cohort 3 — Agentic AI Track.*
