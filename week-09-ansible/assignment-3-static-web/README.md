# Multi-Play Web Deployment on Azure with Ansible

Automate Nginx installation, static website deployment, and HTTP verification across Azure Ubuntu virtual machines using one Ansible playbook with three plays.

**Author:** Saima Usman  
**Program:** DevOps Micro Internship (DMI), Cohort 3 — Agentic AI Track  
**Assignment:** Week 09 · Assignment 03

## Overview

This project demonstrates how Ansible manages multiple web servers from a single controller. Azure infrastructure is provisioned using Terraform, and Ansible configures the existing hosts in the `[web]` inventory group.

The deployment follows three stages:

1. Install Nginx and ensure the service is started and enabled.
2. Copy the locally staged website to each web server and notify an Nginx reload handler when the content changes.
3. Verify every web server from the controller using the `uri` module and assert an HTTP `200` response.

The assignment submission records successful deployment and subsequent content updates on **web1** and **web2**, with browser screenshots and controller-side verification evidence.

## Technology Stack

| Tool | Purpose |
| --- | --- |
| Microsoft Azure | Host the Ubuntu web servers |
| Terraform | Provision the Azure infrastructure |
| Ansible | Configure hosts, deploy content, and verify HTTP responses |
| Nginx | Serve the static website |
| Ubuntu Linux | Operating system on the managed hosts |
| SSH | Connect the controller to the managed hosts |
| HTML | Static website content |

## Deployment Design

| Component | Responsibility |
| --- | --- |
| Ansible controller | Store the inventory, playbook, and website source; run automation |
| `web1` and `web2` | Run Nginx and serve the deployed website |
| Azure Network Security Group | Permit the required SSH and HTTP traffic |
| Localhost verification play | Check each web server over HTTP from the controller |

The controller connects to each web host over SSH for configuration. Website verification uses HTTP on port `80`.

## Project Structure

The assignment uses this project layout:

```text
static-web/
├── inventory.ini
├── site.yml
├── files/
│   └── index.html
└── README.md
```

> This README documents the assignment workflow. The inventory example below is a template; use your actual VM details and existing `site.yml`.

## Prerequisites

- An Ansible controller with Ansible installed.
- Existing Azure Ubuntu VMs provisioned for the lab.
- Public IP addresses or other controller-reachable addresses for the web servers.
- A valid SSH username and private key for those VMs.
- SSH access on port `22` from the controller, restricted to its public IP where applicable.
- HTTP access on port `80` from the controller and the browser used for verification.
- A remote user with the required `sudo` privileges.
- The website's `index.html` staged locally in `files/`.

Check the controller installation:

```bash
ansible --version
ansible-playbook --version
```

## Configure the Inventory

Create or update `inventory.ini` in `static-web/`:

```ini
[web]
web1 ansible_host=<WEB1_PUBLIC_IP>
web2 ansible_host=<WEB2_PUBLIC_IP>

[web:vars]
ansible_user=<AZURE_VM_USERNAME>
ansible_ssh_private_key_file=/absolute/path/to/your/private-key
ansible_python_interpreter=/usr/bin/python3
```

Replace every placeholder before running the commands. Keep the private key outside the repository.

Validate the groups and SSH connectivity:

```bash
cd static-web
ansible-inventory -i inventory.ini --graph
ansible web -i inventory.ini -m ping
```

Ansible's `ping` module checks Ansible connectivity and remote Python execution; it is not an ICMP network ping.

## Stage the Website

Download or copy `index.html` from the [Azure Static Website source repository](https://github.com/pravinmishraaws/Azure-Static-Website) into:

```text
static-web/files/index.html
```

Review the local file before deployment. If you customize the page to reference additional assets, deploy those assets too; the assignment's specified copy task deploys `index.html`.

## Playbook Workflow

### Play 1 — Install and Start Nginx

Target the `web` group and use privilege escalation to:

- Refresh the APT package cache and install Nginx.
- Start the Nginx service.
- Enable Nginx at boot.

### Play 2 — Deploy the Website

Use `ansible.builtin.copy` to deploy the controller's local HTML file:

| Setting | Value |
| --- | --- |
| Source | `files/index.html` |
| Destination | `/var/www/html/index.html` |
| Owner | `www-data` |
| File mode | `'0644'` |
| Notification | Nginx reload handler |

The handler runs when the copy task reports a change. Keeping installation and deployment in separate plays makes each stage easier to understand, maintain, and troubleshoot.

### Play 3 — Verify from the Controller

Run the verification play on `localhost` and loop over every host in `groups['web']`.

For each host, the playbook should:

- Build the HTTP URL using its `ansible_host` address.
- Request the page using `ansible.builtin.uri`.
- Require HTTP status `200`.
- Assert that the returned status is `200` for each result.

Controller-side verification confirms that the site is reachable from outside the managed VM, along the controller's network path.

## Run the Deployment

From `static-web/`, validate playbook syntax:

```bash
ansible-playbook -i inventory.ini site.yml --syntax-check
```

Run the three-play deployment:

```bash
ansible-playbook -i inventory.ini site.yml
```

If the remote sudo configuration requires a password, add `--ask-become-pass` to the deployment command. The installation and deployment plays must use `become: true`, or receive equivalent privilege escalation through the command line.

### Expected Outcome

- Nginx is installed, running, and enabled on both web servers.
- The website is present at `/var/www/html/index.html` with the specified ownership and permissions.
- The Nginx reload handler runs when deployed content changes.
- Controller-side HTTP checks return `200` for every web host.
- The play recap reports `failed=0` and `unreachable=0`.

## Verify Manually

Replace the address placeholders and test both web servers:

```bash
curl -I http://20.41.219.19
curl -I http://104.211.227.39
```

Open each address in a browser:

```text
http://20.41.219.19
http://104.211.227.39
```

Confirm the custom website is displayed on both hosts. An HTTP `200` response confirms a successful request; checking the page content also confirms that the intended website was deployed.

## Update the Website

1. Edit `files/index.html` on the controller.
2. Run the same playbook again:

   ```bash
   ansible-playbook -i inventory.ini site.yml
   ```

3. Refresh both web-server pages and confirm the updated content.

A single invocation targets both servers. Task execution depends on Ansible's configured strategy and concurrency; updates are not guaranteed to occur at exactly the same instant.

Ansible modules such as `apt`, `copy`, and `service` support idempotent configuration. Repeating a run with unchanged inputs should avoid unnecessary changes for those tasks, although cache refreshes and other playbook details can affect the recap.

## Troubleshooting and Lessons Learned

| Issue recorded in the assignment | Resolution |
| --- | --- |
| SSH connectivity and inventory configuration | Verified public IPs, the SSH key path, the VM username, and NSG access rules |
| VM size or quota unavailable in an Azure region | Selected a region with suitable VM capacity and quota |

Key lessons:

- Terraform provisions the infrastructure; Ansible configures the existing servers.
- Separate plays give installation, deployment, and verification clear responsibilities.
- The `copy` module deploys the exact locally staged file consistently across hosts.
- Managed servers do not need Git or direct repository access when the controller distributes the content.
- Handlers make service actions conditional on configuration or content changes.
- Automated checks and browser verification provide complementary deployment evidence.

## Assignment Evidence

The [assignment submission](https://github.com/Saima-Devops/devops-micro-internship-pravinmishra/blob/main/week-09-ansible/assignment-03-multi-play-web-deploy-on-azure.md) contains screenshots showing:

- The project structure and locally staged website.
- The three-play `site.yml`, copy settings, handler, and HTTP assertion.
- A successful playbook run and localhost verification.
- The website loaded in a browser.
- Updated website content on both web servers after another playbook run.

## Security Notes

- Never commit SSH private keys, passwords, or cloud credentials.
- Restrict SSH access to the controller's trusted IP address.
- Redact public IP addresses in shared inventory examples or screenshots when appropriate.
- Keep SSH host-key verification enabled and verify newly encountered hosts.
- This lab uses HTTP for verification; a public production deployment should also configure HTTPS.

## References

- [Assignment 03 — Multi-Play Web Deploy on Azure](https://github.com/Saima-Devops/devops-micro-internship-pravinmishra/blob/main/week-09-ansible/assignment-03-multi-play-web-deploy-on-azure.md)
- [Website Source — Azure Static Website](https://github.com/pravinmishraaws/Azure-Static-Website)
- [DMI Repository — Saima-Devops](https://github.com/Saima-Devops/devops-micro-internship-pravinmishra)

## Author

**Saima Usman**  
Certified DevOps & MultiCloud Engineer

Completed as part of **DevOps Micro Internship (DMI), Cohort 3 — Agentic AI Track**, led by **Pravin Mishra and The CloudAdvisory team**.
