# Assignment 4 — Automate EpicBook Deployment with Dual Pipelines

Part of the DevOps Micro Internship (DMI) with Agentic AI

---

## Purpose

In this assignment, you will automate the EpicBook infrastructure and application deployment on Microsoft Azure using two repositories and two Azure DevOps pipelines. Terraform will provision the infrastructure, and Ansible will configure the servers, connect EpicBook to Azure Database for MySQL, and deploy the application through Nginx.

---

# Task 0 — Verify Accounts, Tools, and Pipeline Capacity

## Goal

Confirm that the required accounts, tools, pipeline agent, SSH key pair, and Terraform remote-state location are ready.

No submission screenshot is required for this task.

---

# Task 1 — Prepare the Two Repositories

## Goal

Create separate Infrastructure and Application Repositories for the EpicBook deployment.

No submission screenshot is required for this task.

---

# Task 2 — Configure Azure DevOps Connections, Secure Files, and Secrets

## Goal

Configure controlled pipeline access to GitHub, Microsoft Azure, the virtual machines, and Azure Database for MySQL.

No submission screenshot is required for this task.

> Do not expose the Azure Client Secret, SSH private key, MySQL password, access token, subscription ID, or another sensitive value.

---

# Task 3 — Author the Terraform Infrastructure Configuration

## Goal

Define the complete EpicBook Azure infrastructure using Terraform and an Azure Storage remote backend.

No submission screenshot is required for this task.

---

# Task 4 — Author and Run the Infrastructure Pipeline

## Goal

Validate, plan, approve, and apply the Terraform configuration through the Infrastructure Pipeline.

## Flow Concept

```
Azure DevOps Pipeline
       │
       ├── Secure File: azure-ansible
       │       └── SSH private key
       │
       └── Variable Group: Epicbook-mysql-secrets
               ├── mysqlAdminUsername
               └── mysqlAdminPassword (secret)
                         │
                         ▼
                    Ansible
                         │
                         ▼
              Azure MySQL Flexible Server
                    bookstore DB
```

## Evidence

### Screenshot 1 — Successful Infrastructure Pipeline

Add a screenshot of the Infrastructure Pipeline run showing:

* Successful `terraform apply` completion
* `app_public_ip`
* `backend_ansible_host`
* `backend_private_ip`
* `mysql_fqdn`

> Do not expose the MySQL password, Client Secret, Terraform state, SSH private key, or another sensitive value.

### Local Deployment Check

![alt text](screenshots/Assign-4/Screenshot-1.png)

![alt text](screenshots/Assign-4/Screenshot-6.png)
<br>

**All good!**

> Removed all provisioning through `terraform destroy` and then re-provisioned through Azure Pipelines.

---

### Screenshot 2 — Provisioned Azure Resources

Add a screenshot of the Azure Portal Resource Group overview showing:

* Virtual Network and related networking resources
* Frontend VM
* Backend VM
* Azure Database for MySQL Flexible Server
* Related EpicBook resources

**AZURE PIPELINES**

![alt text](screenshots/Assign-4/Screenshot-18.png)

![alt text](screenshots/Assign-4/Screenshot-15.png)

![alt text](screenshots/Assign-4/Screenshot-11.jpg)

![alt text](screenshots/Assign-4/Screenshot-12.jpg)

![alt text](screenshots/Assign-4/Screenshot-2.png)

![alt text](screenshots/Assign-4/Screenshot-3.png)

![alt text](screenshots/Assign-4/Screenshot-5.png)


> Hide sensitive IDs, credentials, and database details.

---

# Task 5 — Complete the Manual Terraform-to-Ansible Handoff

## Goal

Transfer the required non-sensitive Terraform outputs to the Application Repository for use by Ansible.

No submission screenshot is required for this task.

---

# Task 6 — Author the Ansible Application Configuration

## Goal

Create idempotent Ansible automation that configures the frontend and backend VMs, prepares the database, configures Nginx, and deploys EpicBook.

No submission screenshot is required for this task.

---

# Task 7 — Author and Run the Application Pipeline

## Goal

Run the Application Pipeline to configure the VMs, deploy EpicBook, and verify the application environment.

## Evidence

### Screenshot 3 — Successful Application Pipeline

Add a screenshot of the Application Pipeline run summary showing all required stages or jobs succeeded.

![alt text](screenshots/Assign-4/ansible-pipeline.jpg)
---

### Screenshot 4 — Successful Ansible Play Recap

Add a screenshot of the Application Pipeline log showing:

* Ansible play recap
* Successful configuration or verification
* Zero failed hosts
* Zero unreachable hosts

![alt text](screenshots/Assign-4/Screenshot-14.jpg)

> Do not expose the SSH private key, MySQL password, Client Secret, or complete database connection string.

---

# Task 5 — Verify the Complete EpicBook Workflow

## Goal

Verify that the frontend, backend, and Azure Database for MySQL work together correctly.

## Evidence

### Screenshot 5 — Running EpicBook Application

Add a browser screenshot showing:

* Running EpicBook application
* Frontend public IP address in the browser address bar
* Your Full Name
* Deployment date

The screenshot may show a product, cart, or successful order view.

![alt text](screenshots/Assign-4/Screenshot-8.png)

![alt text](screenshots/Assign-4/Screenshot-9.png)

![alt text](screenshots/Assign-4/Screenshot-10.png)

> Do not expose credentials or sensitive information.

---

# Required URLs

## Frontend Application URL

http://52.172.94.142

## Infrastructure Repository URL

https://github.com/Saima-Devops/infra-epicbook.git

## Application Repository URL

https://github.com/Saima-Devops/theepicbook.git

---

# Two-Repository Model

Write a short explanation of why separate Infrastructure and Application Repositories were used.

```
                    AZURE DEVOPS
                         │
              ┌──────────┴──────────┐
              │                     │
        Terraform Pipeline     Ansible/App Pipeline
              │                     │
              ▼                     ▼
        Azure Infrastructure    Application Deployment
              │                     │
              ▼                     ▼
        VMs / Network / DB      Ansible
                                      │
                         ┌────────────┼────────────┐
                         ▼            ▼            ▼
                       Backend     Database      Frontend
```




[Write your explanation here.]


---

### Final Execution


```
                    ┌──────────────────────────┐
                    │        GitHub            │
                    └────────────┬─────────────┘
                                 │
                    ┌────────────┴────────────┐
                    │                         │
                    ▼                         ▼
        ┌────────────────────┐    ┌────────────────────┐
        │   infra-epicbook   │    │    theepicbook     │
        │   Terraform repo   │    │  Application repo  │
        └─────────┬──────────┘    └─────────┬──────────┘
                  │                         │
                  ▼                         ▼
        Epicbook-infra-pipeline     Epicbook-App-Pipeline
                  │                         │
                  ▼                         ▼
        Terraform plan/apply         Ansible deployment
                  │                         │
                  ▼                         ▼
        Azure infrastructure          EpicBook application
                  │                         │
                  └────────────┬────────────┘
                               ▼
                     ┌──────────────────┐
                     │ Azure Production │
                     │                  │
                     │ Frontend VM      │
                     │ Backend VM       │
                     │ MySQL            │
                     └──────────────────┘
```

So `theepicbook` is our production application deployment trigger.

---

# Manual Terraform-to-Ansible Handoff

Write a short explanation of how the following non-sensitive Terraform outputs were transferred to the Application Repository:

* `app_public_ip`
* `backend_ansible_host`
* `backend_private_ip`
* `mysql_fqdn`

## Manual Terraform-to-Ansible Handoff

After the Terraform infrastructure was successfully applied, the required non-sensitive outputs were obtained using `terraform output`. The values were manually transferred to the Application Repository and added to `ansible/inventory.ini` and the Ansible group variables.

The handoff was:
- `app_public_ip` → used as the `ansible_host` for `frontend-vm`.
- `backend_ansible_host` → used as the `ansible_host` for `backend-vm`.
- `backend_private_ip` → added to the backend inventory so the frontend Nginx configuration could proxy to the backend over its private IP.
- `mysql_fqdn` → added to the backend variables as the MySQL database host.

Only non-sensitive infrastructure addressing information was transferred. The MySQL password and SSH private key were not stored in the repository; they were supplied securely through Azure DevOps secrets and Secure Files.

---

# LinkedIn Requirement

## Evidence

### Screenshot 6 — LinkedIn Post

Add a screenshot of your LinkedIn post showing:

* Post text
* At least one image or link

![alt text](screenshots/Assign-4/Screenshot-17.png)

## LinkedIn Post URL

https://www.linkedin.com/posts/saima-usman_azuredevops-devops-azure-share-7507144574600085504-bsmr


Your post must include:

* What you automated
* Why separate Infrastructure and Application Repositories were used
* A brief explanation of the Terraform and Ansible pipelines
* How Azure credentials, the SSH key, and database secrets were protected
* One challenge you encountered
* How you solved the challenge
* Relevant technologies and skills

> Do not expose credentials, SSH keys, database passwords, subscription details, or other sensitive information.

---

# Submission Instructions

* Complete all tasks in sequence.
* Include your Full Name.
* Include a short explanation of the two-repository model.
* Include a short explanation of the manual Terraform-to-Ansible handoff.
* Include the Infrastructure Repository URL.
* Include the Application Repository URL.
* Include the final EpicBook application URL.
* Include Screenshots 1–6.
* Include the public LinkedIn post URL.
* Confirm that all screenshots are readable.
* Do not include Terraform state.
* Do not expose the Azure Client Secret, MySQL password, SSH private key, access token, complete connection string, subscription ID, tenant ID, account ID, or another sensitive value.
* Follow the Assignment Submission Guidelines.

---

# Completion Checklist

* [✅] Two separate repositories were created
* [✅] The Infrastructure Repository contains Terraform and its pipeline
* [✅] The Application Repository contains EpicBook, Ansible, and its pipeline
* [✅] Your Full Name and deployment date are visible in EpicBook
* [✅] Both pipelines use the intended `main` branch
* [✅] The Azure Resource Manager Service Connection works
* [✅] The Azure Client Secret is not stored in Git or YAML
* [✅] Terraform uses an Azure Storage remote backend
* [✅] Terraform state was not published or committed
* [✅] Separate frontend, backend, and database subnets were created
* [✅] The frontend VM accepts public HTTP traffic on port 80
* [✅] SSH access is restricted
* [✅] The backend application port is not publicly accessible
* [✅] Azure Database for MySQL uses private access
* [✅] The Infrastructure Pipeline validates, plans, applies, and displays non-sensitive outputs
* [✅] The reviewed Terraform plan was used during Apply
* [✅] Approval or manual validation occurred before Apply
* [✅] `app_public_ip` is available
* [✅] `backend_ansible_host` is available
* [✅] `backend_private_ip` is available
* [✅] `mysql_fqdn` is available
* [✅] Only non-sensitive Terraform outputs were transferred to the Application Repository
* [✅] The SSH private key is stored in Azure DevOps Secure Files
* [✅] The SSH private key was not committed or published
* [✅] The MySQL password is stored as a secret pipeline variable
* [✅] Ansible reaches both frontend and backend VMs
* [✅] Ansible completes with zero failed and zero unreachable hosts
* [✅] Nginx proxies requests to the backend private IP
* [✅] EpicBook runs as a persistent service
* [✅] The database schema and seed data are available
* [✅] The application displays database-backed products
* [✅] Cart or checkout actions are recorded in MySQL
* [✅] The final application displays your Full Name and deployment date
* [✅] Screenshots 1–6 are included and readable
* [✅] The Infrastructure Repository URL is included
* [✅] The Application Repository URL is included
* [✅] The final EpicBook application URL is included
* [✅] The LinkedIn post is published
* [✅] The LinkedIn post URL is included
* [✅] No secret or sensitive identifier is exposed

---

*This submission is part of the DevOps Micro Internship (DMI) — Agentic AI Track.*