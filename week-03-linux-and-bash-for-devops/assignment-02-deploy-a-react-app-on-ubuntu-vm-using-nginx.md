# Assignment 2 — Deploy a React App on Ubuntu VM Using Nginx

Part of the DevOps Micro Internship (DMI) Cohort 3 with Agentic AI

---

## Purpose

In this assignment, you will deploy a React application on an Ubuntu EC2 instance and serve it using Nginx. You will provision a Linux server, install the required tools, personalize the application with your details, and verify that it is publicly accessible via a browser.

---

# Task 1 — Setup Environment (Node.js & npm)

## Goal

Install Node.js and npm on the Ubuntu VM and verify the installation.

### Evidence

#### Screenshot 1 — Output of `node -v && npm -v` showing installed versions


<img width="1291" height="472" alt="image" src="https://github.com/user-attachments/assets/a8977964-55fe-425c-8016-c96a69528531" />

---

# Task 2 — Setup Environment (Nginx)

## Goal

Install Nginx, start the service, and confirm it is running.

### Evidence

#### Screenshot 2 — Output of `systemctl status nginx --no-pager` showing Active (running)

<img width="1287" height="671" alt="image" src="https://github.com/user-attachments/assets/d8f99dd7-b9bf-4ae8-a5bc-b7a76445e92c" />


---

# Task 3 — Clone React Application

## Goal

Clone the project repository and verify the project files are present.

### Evidence

#### Screenshot 3 — Output of `ls` inside the `my-react-app` directory showing project files

<img width="970" height="702" alt="image" src="https://github.com/user-attachments/assets/8f06385a-89a1-4bde-9a92-7f009679bbda" />


---

# Task 4 — Modify Application (Personalization)

## Goal

Update `App.js` with your full name and the current date.

### Evidence

#### Screenshot 4 — `nano App.js` open showing your full name and date filled in

<img width="1917" height="995" alt="image" src="https://github.com/user-attachments/assets/c9b6d659-8b89-43b7-bc6c-5ee8b0f3f74a" />


---

# Task 5 — Build React Application

## Goal

Install dependencies and generate the production build.

### Evidence

#### Screenshot 5 — Output of `ls` inside `my-react-app` showing the `build/` folder generated

<img width="1917" height="627" alt="image" src="https://github.com/user-attachments/assets/c24bd555-5046-4417-993b-d46556da95b1" />

---

# Task 6 — Deploy React Build to Nginx Web Root

## Goal

Copy the production build files to the Nginx web root directory.

### Evidence

#### Screenshot 6 — Output of `ls /var/www/html/` showing the deployed build contents

<img width="1876" height="467" alt="image" src="https://github.com/user-attachments/assets/69451001-03de-4f4e-8779-5365f53f98f0" />

---

# Task 7 — Configure Nginx for React Application

## Goal

Apply Nginx configuration for React routing and confirm the service is active.

### Evidence

#### Screenshot 7 — Output of `systemctl is-active nginx` showing `active`

<img width="1917" height="372" alt="image" src="https://github.com/user-attachments/assets/6ca49f37-1e04-4678-b5a9-45a1da240848" />

<img width="1866" height="502" alt="image" src="https://github.com/user-attachments/assets/2d4eed8f-6333-4d09-a2e8-125cdc8484cb" />


---

#### Screenshot 8 — Output of `cat /etc/nginx/sites-available/default` showing the Nginx config

<img width="1917" height="701" alt="image" src="https://github.com/user-attachments/assets/c493a694-24af-43bc-b482-47f549a59b96" />


---

# Task 8 — Test Deployment

## Goal

Verify the React application is publicly accessible via the server's public IP.

### Evidence

#### Screenshot 9 — Output of `curl ifconfig.me` showing the server's public IP address

<img width="1917" height="451" alt="image" src="https://github.com/user-attachments/assets/4de7f877-44f5-4ee8-878b-8e54d7cac17e" />

---

#### Screenshot 10 — Browser showing the deployed React app at `http://<public-ip>` with your name and date visible

<img width="1917" height="870" alt="image" src="https://github.com/user-attachments/assets/7b063b30-f326-46d2-90fb-0a91ef83ae76" />

<img width="1917" height="621" alt="image" src="https://github.com/user-attachments/assets/68359050-057e-48b0-95b0-fc1a5775fa6e" />

---

# LinkedIn Post (Required)

## Evidence

#### LinkedIn Post URL

https://www.linkedin.com/posts/saima-usman_aws-ec2-ubuntu-share-7484687219924983808-3hdw/?utm_source=share&utm_medium=member_desktop&rcm=ACoAABsfrYoBkq_t-PkQCt7fEB9Ajmp98YTHl_g

---

#### Screenshot — LinkedIn post showing the deployed application

<img width="1217" height="917" alt="image" src="https://github.com/user-attachments/assets/9f43b1ff-d68c-41b6-b218-0e203b38dc7c" />


---

# Submission Instructions

- Add all required screenshots in your submission
- Full name must be visible in required screenshots
- Do not expose sensitive information (keys, passwords, account IDs)

---

# Completion Checklist

- [✔️] Node.js and npm installed and verified (Screenshot 1)
- [✔️] Nginx installed and running (Screenshot 2)
- [✔️] Repository cloned and files verified (Screenshot 3)
- [✔️] App.js updated with full name and date (Screenshot 4)
- [✔️] Production build generated (Screenshot 5)
- [✔️] Build files deployed to Nginx web root (Screenshot 6)
- [✔️] Nginx configured and active (Screenshots 7 & 8)
- [✔️] Public IP retrieved (Screenshot 9)
- [✔️] React app accessible in browser with personal details visible (Screenshot 10)
- [✔️] LinkedIn post published and URL submitted
- [✔️] No sensitive data exposed

---

## 📌 About DMI & CloudAdvisory

DevOps Micro Internship (DMI) is a project-based DevOps program run by Pravin Mishra (The CloudAdvisory) focused on real-world execution, systems thinking, and career readiness.

It helps learners build strong DevOps foundations with hands-on experience.

---

## 📌 Resources

- 🌐 DMI Official Website: https://pravinmishra.com/dmi  
- 🎓 DevOps for Beginners (Udemy): https://www.udemy.com/course/devops-for-beginners-docker-k8s-cloud-cicd-4-projects/  
- 🎓 Agentic AI DevOps with Claude Code: https://www.udemy.com/course/ultimate-agentic-ai-devops-with-claude-code/  
- 🎓 DevOps with Claude Code: Terraform, EKS, ArgoCD & Helm: https://www.udemy.com/course/devops-with-claude-code-terraform-eks-argocd-helm/  
- ▶️ YouTube Playlist: https://www.youtube.com/playlist?list=PLFeSNDtI4Cho  
- 🔗 Pravin Mishra (LinkedIn): https://www.linkedin.com/in/pravin-mishra-aws-trainer/  
- 🏢 CloudAdvisory (LinkedIn): https://www.linkedin.com/company/thecloudadvisory/

---

*This submission is part of DevOps Micro Internship (DMI) Cohort 3 — Agentic AI Track.*
