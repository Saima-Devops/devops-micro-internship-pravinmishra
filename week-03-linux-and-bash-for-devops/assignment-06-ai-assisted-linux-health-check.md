# Assignment 6 — Build an AI-Assisted Linux Health Check (AI-Assisted Linux Incident Triage)

Part of the DevOps Micro Internship (DMI) Cohort 3 with Agentic AI

---

## Purpose

In this assignment, you will build a read-only Bash triage script that checks the health of your Ubuntu server and Nginx application, connect it to Claude Code as a reusable `/linux-triage` skill, simulate a controlled Nginx incident, use the skill to gather and analyze evidence, recover the service manually, and verify recovery. The workflow follows the Agentic Loop: Gather → Analyze → Human Act → Verify.

---

# Task 1 — Confirm the Healthy Baseline and Create the Workspace

## Goal

Confirm that Nginx and the React application are healthy before building the automation.

### Evidence

#### Screenshot 1 — Output of `systemctl is-active nginx`, `ss -ltn | grep ':80'`, and `curl -I http://localhost`

![alt text](screenshots/assign6-img1.png)

---

#### Screenshot 2 — Output of `pwd` and `find . -maxdepth 4 -type d | sort` showing the workspace folder structure

![alt text](screenshots/assign6-img-2.png)
---

### Notes

Answer the following in your own words:

**1. What proves that Nginx is running?**

The command systemctl is-active nginx returns **active**, confirming that the Nginx service is running successfully.
---

**2. What proves that the server is listening for HTTP traffic?**

The command `ss -ltn | grep ':80'` shows that port 80 is listening, and `curl -I http://localhost` returns an HTTP response, proving the server is accepting HTTP requests.

---

**3. Why must you capture a healthy baseline before simulating an incident?**

A healthy baseline provides a known working state, making it easier to identify what changed during the incident and verify that the recovery restored the system correctly.

---

# Task 2 — Create Project Context and Safety Rules in CLAUDE.md

## Goal

Tell Claude exactly what this project does and what it is not allowed to do.

### Evidence

#### Screenshot 3 — CLAUDE.md open in VS Code showing all four sections (Project Overview, Incident Workflow, Safety Rules, Output Rules)

![alt text](screenshots/assign6-img-3.png)

![alt text](screenshots/assign6-img-4.png)
---

### Notes

Answer the following in your own words:

**1. Why should Claude receive project-specific operational rules?**

Project-specific rules ensure Claude understands the environment, follows the correct workflow, and avoids performing unsafe or unauthorized actions.

---

**2. Why is the human required to execute the recovery command?**

The human operator must approve and execute recovery actions to maintain control over production systems and prevent unintended changes.

---

**3. Which rule prevents Claude from making an unsupported diagnosis?**

The rule requiring Claude to base conclusions only on collected evidence prevents unsupported assumptions or guesses.

---

# Task 3 — Use Agentic AI to Plan Before Writing the Script

## Goal

Use Claude Code to inspect the environment and produce a read-only plan before creating any Bash code.

### Evidence

#### Screenshot 4 — Claude Code showing the five-check plan and read-only inspection results

![alt text](screenshots/assign6-img-5.png)

![alt text](screenshots/assign6-img-6.png)

![alt text](screenshots/assign6-img-7.png)

![alt text](screenshots/assign6-img-8.png)

![alt text](screenshots/assign6-img-9.png)

![alt text](screenshots/assign6-img-10.png)

---

### Notes

Answer the following in your own words:

**1. Which part of this task represents the Gather phase?**

The environment inspection and collection of system information represent the Gather phase.
---

**2. Did Claude follow the instruction not to create files? How did you verify this?**

Yes. Claude only inspected the environment and displayed a plan without creating any new files or modifying existing ones.

---

**3. Why is planning before coding useful in DevOps automation?**

Planning helps identify requirements, reduces mistakes, and ensures the automation follows the intended workflow before implementation.

---

# Task 4 — Build the Linux Triage Bash Script

## Goal

Create one Bash script that gathers consistent Linux and Nginx health evidence.

### Evidence

#### Screenshot 5 — Top section of `linux-triage.sh` showing variables, thresholds, and the checks array

![alt text](screenshots/assign6-img-12-start.png)

---

#### Screenshot 6 — Middle section showing check functions and conditionals

![alt text](screenshots/assign6-img-12-mid.png)

---

#### Screenshot 7 — Bottom section showing the loop, summary function, and exit behavior

![alt text](screenshots/assign6-img-12-end.png)

---

#### Screenshot 8 — Output of `bash -n scripts/linux-triage.sh` (no syntax errors) and `ls -l scripts/linux-triage.sh` showing executable permission

![alt text](screenshots/assign6-img-12.png)

---

### Notes

Answer the following in your own words:

**1. What is stored in the checks array?**

The checks array stores the names of all health-check functions that need to be executed.
---

**2. How does the `for` loop use that array?**

The loop iterates through each function name in the array and executes every health check automatically.

---

**3. Why are the health checks separated into functions?**

Functions improve readability, simplify maintenance, and allow each health check to be reused independently.

---

**4. What is the purpose of `$(...)` in this script?**

$(...) performs command substitution by capturing the output of a command so it can be used inside variables or conditions.

---

**5. Why does the script use different exit codes for HEALTHY, WARN, and FAIL?**

Different exit codes allow automation tools and users to distinguish between normal operation, warnings, and critical failures.

---

# Task 5 — Run and Understand the Healthy-State Report

## Goal

Run the Bash script against the healthy server and verify that it creates a report.

### Evidence

#### Screenshot 9 — Output of `./scripts/linux-triage.sh` showing my Full Name and all five check results

![alt text](screenshots/assign6-img-11.png)

---

#### Screenshot 10 — Output showing the captured exit code and final summary

![alt text](screenshots/assign6-img-15.png)

---

### Notes

Answer the following in your own words:

**1. What is the overall status of your healthy baseline?**

The server is healthy, all health checks passed, and the application is accessible.

---

**2. Which exact Linux evidence proves the application is serving traffic?**

The successful response from `curl -I http://localhost` with HTTP/1.1 200 OK proves the application is serving traffic.

---

**3. Did your script return exit code 0 or 1? Explain why.**

The script returned 0 because all required health checks passed without any failures.

---

**4. What is the difference between a warning and a failure in this script?**

A warning indicates a non-critical issue that does not stop the service, while a failure indicates a critical problem requiring immediate attention.

---

# Task 6 — Create and Run the /linux-triage Skill

## Goal

Turn the Bash script into a reusable, manually invoked Agentic AI workflow.

### Evidence

#### Screenshot 11 — `SKILL.md` showing the frontmatter, allowed tool restrictions, and safety rules

![alt text](screenshots/assign6-img-14-a.png)

---

#### Screenshot 12 — `/linux-triage` output for the healthy server

![alt text](screenshots/assign6-img-16.png)

![alt text](screenshots/assign6-img-17.png)

---

### Notes

Answer the following in your own words:

**1. Why does this skill have Bash, Read, and Grep, but not Write?**

The skill is designed only to collect and analyze system information, ensuring it cannot modify files or change the server.

---

**2. Why is `disable-model-invocation: true` useful for this skill?**

It ensures the workflow relies only on predefined commands, making the execution predictable and reducing unnecessary AI-generated actions.

---

**3. What part is performed by Bash, and what part is performed by Claude?**

Bash gathers system health data, while Claude analyzes the collected evidence and explains the findings.

---

**4. Why is this better than asking Claude "Is my server healthy?" without giving it evidence?**

Because Claude bases its analysis on actual system data instead of making assumptions.

---

# Task 7 — Simulate an Nginx Incident and Let the Skill Diagnose It

## Goal

Create a controlled service failure, gather evidence through Bash, and let Claude analyze the evidence without taking recovery action.

### Evidence

#### Screenshot 13 — Output showing Nginx is inactive and the HTTP request fails

![alt text](screenshots/assign6-img-19.png)

---

#### Screenshot 14 — `/linux-triage` output showing failed evidence, most likely cause, and a suggested recovery command

![alt text](screenshots/assign6-img-22.png)

---

#### Screenshot 15 — `incident-failure-report.txt` showing the failed checks and your Full Name

![alt text](screenshots/assign6-img-24.png)

---

### Notes

Answer the following in your own words:

**1. Which three checks failed?**

The Nginx service status check, the HTTP connectivity check, and the web server availability check failed.

---

**2. What evidence supports the conclusion that Nginx is unavailable?**

`systemctl is-active nginx` returned inactive, and `curl -I http://localhost` failed to connect.

---

**3. Did Claude execute the recovery command? Why is that important?**

No. Claude only suggested the recovery command because operational changes must be approved and executed by the human operator.

---

**4. Which phase of the Agentic Loop is represented by the Bash report?**

The Bash report represents the Gather phase.

---

**5. Which phase is represented by Claude's explanation?**

Claude's explanation represents the Analyze phase.

---

# Task 8 — Recover Manually, Verify Again, and Write the Incident Summary

## Goal

Recover the service as the human operator and prove that the system is healthy again.

### Evidence

#### Screenshot 16 — Output showing Nginx is active and `curl -I http://localhost` returns 200 OK

![alt text](screenshots/assign6-img-25.png)

---

#### Screenshot 17 — Second `/linux-triage` output showing successful recovery with no FAIL results

![alt text](screenshots/assign6-img-26.png)

---

#### Screenshot 18 — Output of `ls -lah reports` showing both `incident-failure-report.txt` and `recovery-report.txt`

![alt text](screenshots/assign6-img-27.png)

---

#### Screenshot 19 — `incident-summary.md` showing all required sections and your Full Name

![alt text](screenshots/assign6-img-28.png)

![alt text](screenshots/assign6-img-29.png)

---

### Notes

Answer the following in your own words:

**1. What action did you execute manually?**

I manually restarted the Nginx service using:

```
sudo systemctl start nginx
```

---

**2. What evidence proves that the service recovered?**

Nginx became active, `curl -I http://localhost` returned 200 OK, and the second health report showed no failures.

---

**3. Why is the second triage run necessary?**

It verifies that the recovery was successful and confirms the system returned to a healthy state.

---

**4. What could go wrong if an AI agent automatically restarted every failed service?**

It could hide the real issue, interrupt running applications, cause repeated failures, or restart services that should remain stopped.

---

**5. In one sentence, explain the difference between using AI as a chatbot and using AI in this agentic workflow.**

A chatbot simply answers questions, while an agentic workflow uses real system evidence to assist human decision-making through a structured process.

---

# Incident Summary

Fill in all seven sections below in your own words.

**Full Name:** Saima Usman

**Date:** 25/07/2026

---

**1. Reported Symptom**

The web application became inaccessible because the Nginx service was intentionally stopped during the incident simulation.

---

**2. Evidence Collected**

The Bash triage script collected service status, port listening information, HTTP response results, system health data, and generated a structured incident report.

---

**3. Most Likely Cause**

The Nginx service was inactive, preventing the server from accepting HTTP requests.

---

**4. Human-Approved Recovery Action**

I manually restarted the Nginx service using sudo systemctl start nginx.

---

**5. Verification**

A second health check confirmed Nginx was active, HTTP requests returned 200 OK, and all health checks passed.

---

**6. Safety Decision**

Claude only analyzed the collected evidence and suggested a recovery command, while the actual recovery was performed manually to maintain operational safety.

---

**7. Agentic Loop Mapping**

**Gather:** Bash script collected health data.

**Analyze:** Claude interpreted the evidence.

**Human Act:** I manually restarted Nginx.

**Verify:** The triage script confirmed successful recovery.

---

# LinkedIn Post (Required)

## Evidence

#### LinkedIn Post URL

https://www.linkedin.com/posts/saima-usman_devops-linux-bash-share-7486819765420724224-P0Jq/?utm_source=share&utm_medium=member_desktop&rcm=ACoAABsfrYoBkq_t-PkQCt7fEB9Ajmp98YTHl_g

---

#### Screenshot — Published LinkedIn post

![alt text](screenshots/assign6-img-30.png)

---

# GitHub Repository URL

Paste the URL of your GitHub folder or repository containing the assignment files here:

https://github.com/Saima-Devops/devops-micro-internship-pravinmishra/tree/main

---

# Submission Instructions

- Add all required screenshots in your submission
- Full Name must be visible in required screenshots and the Bash report
- All written answers must be in your own words
- Do not expose sensitive information (keys, passwords, AWS account IDs, tokens)
- GitHub URL must be included in this document

---

# Completion Checklist

- [✔️] Task 1: Healthy baseline confirmed, workspace created (Screenshots 1–2, Notes answered)
- [✔️] Task 2: CLAUDE.md created with all four sections (Screenshot 3, Notes answered)
- [✔️] Task 3: Five-check plan produced by Claude using read-only tools (Screenshot 4, Notes answered)
- [✔️] Task 4: `linux-triage.sh` created, syntax validated, executable permission set (Screenshots 5–8, Notes answered)
- [✔️] Task 5: Healthy-state report generated with no FAIL result (Screenshots 9–10, Notes answered)
- [✔️] Task 6: `/linux-triage` skill created and run successfully on healthy server (Screenshots 11–12, Notes answered)
- [✔️] Task 7: Nginx incident simulated, failed evidence captured, Claude did not execute recovery (Screenshots 13–15, Notes answered)
- [✔️] Task 8: Nginx recovered manually, recovery verified, reports saved, incident summary complete (Screenshots 16–19, Notes answered)
- [✔️] Incident summary contains all seven required sections
- [✔️] LinkedIn post published and URL submitted
- [✔️] Full Name visible in all required screenshots and the Bash report
- [✔️] Skill does not have Write permission
- [✔️] Skill did not execute any recovery commands
- [✔️] No sensitive data exposed

---

## 📌 About DMI & CloudAdvisory

DevOps Micro Internship (DMI) is a project-based DevOps program run by Pravin Mishra (The CloudAdvisory) focused on real-world execution, systems thinking, and career readiness.

It helps learners build strong DevOps foundations with hands-on experience.

---

## 📌 Resources

- 🌐 DMI Official Website:  https://dmi.pravinmishra.com  
- 🎓 DevOps for Beginners (Udemy): https://www.udemy.com/course/devops-for-beginners-docker-k8s-cloud-cicd-4-projects/  
- 🎓 Agentic AI DevOps with Claude Code: https://www.udemy.com/course/ultimate-agentic-ai-devops-with-claude-code/  
- 🎓 DevOps with Claude Code: Terraform, EKS, ArgoCD & Helm: https://www.udemy.com/course/devops-with-claude-code-terraform-eks-argocd-helm/  
- ▶️ YouTube Playlist: https://www.youtube.com/playlist?list=PLFeSNDtI4Cho  
- 🔗 Pravin Mishra (LinkedIn): https://www.linkedin.com/in/pravin-mishra-aws-trainer/  
- 🏢 CloudAdvisory (LinkedIn): https://www.linkedin.com/company/thecloudadvisory/

---

*This submission is part of DevOps Micro Internship (DMI) Cohort 3 — Agentic AI Track.*