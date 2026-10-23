# Assignment 11 — AI-Assisted Kubernetes Incident Triage

Part of the DevOps Micro Internship (DMI) with Agentic AI

---

## Purpose

In this assignment, you will build a read-only Bash script that checks the health of the Book Review App running on your Kubernetes cluster, connect it to Claude Code as a reusable `/k8s-triage` skill, then deliberately break your own deployment, use the skill to diagnose the failure from evidence alone, recover it yourself, and verify the fix. This closes out the AI Assignment series with the same discipline applied at every layer so far — a single Linux host, two clouds, Terraform, Ansible, a CI/CD pipeline, a Docker image, and now an orchestrated Kubernetes cluster: gather evidence with a read-only tool, let AI analyze it and recommend a fix, keep a human in charge of every action that changes the cluster, and verify again.

---

# Task 1 — Confirm the Healthy Baseline and Create the Workspace

## Goal

Confirm every Book Review App pod is `Running` and `Ready` and that its Service has active Endpoints, then set up a workspace folder for this assignment before writing any automation.

### Evidence

#### Screenshot 1 — `kubectl get pods` and `kubectl get endpoints` showing the Book Review App healthy

![alt text](screenshots/Assignment-11/Screenshot-1.png)

---

#### Screenshot 2 — Workspace folder structure for this assignment

![alt text](screenshots/Assignment-11/Screenshot-2.png)

---

# Task 2 — Add Safety Rules to CLAUDE.md

## Goal

Add a `CLAUDE.md` telling Claude this is a read-only Kubernetes triage workflow: it must never run `kubectl apply`, `delete`, `rollout restart`, `edit`, or `scale` on its own, and every recovery action must be reviewed and run by you.

### Evidence

#### Screenshot 3 — `CLAUDE.md` showing the project overview, incident workflow, and safety rules

![alt text](screenshots/Assignment-11/Screenshot-3.png)

---

# Task 3 — Use Agentic AI to Plan the Triage Checks

## Goal

Ask Claude to propose a read-only, five-check `kubectl` triage plan — pod status, pod readiness, restart counts, recent namespace events, and Service endpoints — before you write any script.

### Evidence

#### Screenshot 4 — Claude's proposed five-check plan, with no file created or cluster state changed

![alt text](screenshots/Assignment-11/Screenshot-4.png)

---

# Task 4 — Build the Kubernetes Triage Script

## Goal

Write a Bash script that runs the five read-only `kubectl` checks and writes a PASS/WARN/FAIL report with an overall status and exit code.

### Evidence

#### Screenshot 5 — Script showing the five checks and how each one gathers its evidence

![alt text](screenshots/Assignment-11/week-12-ss-5.png)

---

#### Screenshot 6 — `bash -n` and `ls -l` confirming the script is valid and executable

![alt text](screenshots/Assignment-11/week-12-ss-6.png)

---

# Task 5 — Run the Script Against the Healthy Cluster

## Goal

Run the script against your current, unmodified deployment and confirm it reports a clean, healthy baseline before you simulate anything.

### Evidence

#### Screenshot 7 — Script output showing all five checks passing

![alt text](screenshots/Assignment-11/week-12-ss-7.png)

---

# Task 6 — Build and Run the /k8s-triage Skill

## Goal

Wrap the script in a Claude Code skill restricted to read-only tools (no `Write`), and confirm `/k8s-triage` reports the healthy baseline using the script's evidence without touching the cluster.

### Evidence

#### Screenshot 8 — `SKILL.md` frontmatter showing the tool restrictions and safety rules

![alt text](screenshots/Assignment-11/week-12-ss-8.png)

---

#### Screenshot 9 — `/k8s-triage` output for the healthy cluster

![alt text](screenshots/Assignment-11/week-12-ss-9.png)

---

# Task 7 — Simulate an Incident and Let the Skill Diagnose It

## Goal

Deliberately break your own deployment — an image tag that does not exist, or a misconfigured readiness probe — then run `/k8s-triage` and confirm it correctly identifies the failure, quotes the evidence, and recommends a fix without applying it.

### Evidence

#### Screenshot 10 — The pod in a failed state and the Service showing no Endpoints

![alt text](screenshots/Assignment-11/week-12-ss-10.png)

---

#### Screenshot 11 — `/k8s-triage` output showing the diagnosis and the recommended `kubectl` command, not executed by Claude

![alt text](screenshots/Assignment-11/week-12-ss-11.png)
---

# Task 8 — Recover, Verify, and Summarize

## Goal

Review the recommendation, apply the fix yourself, confirm the pod returns to `Running`/`Ready` with active Endpoints, run `/k8s-triage` again to verify, and write a short incident summary.

### Evidence

#### Screenshot 12 — Pod back to `Running`/`Ready` and the Service showing Endpoints again

![alt text](screenshots/Assignment-11/week-12-ss-12.png)

---

#### Screenshot 13 — Second `/k8s-triage` run confirming recovery

![alt text](screenshots/Assignment-11/week-12-ss-13.png)

---

### Notes

Compare this incident to the Nginx incident from Week 3's AI-Assisted Linux Health Check. What stayed the same about the process, and what changed about the evidence you had to gather?

### Notes

**What stayed the same:**  
The overall approach followed the same pattern as the Week 3 Nginx incident: collect evidence with a read-only Bash script, use a Claude Code skill to analyse the findings, manually apply the fix, and rerun the check to confirm recovery. In both incidents, Claude could only inspect the evidence and recommend commands. I reviewed its suggestions and executed the changes myself. Running the same script before and after each fix provided a consistent comparison of the failed and recovered states.

**What changed about the evidence:**  
In Week 3, the investigation focused on a single Linux host. The evidence included service status, listening ports, HTTP responses, available disk space, and service logs. In Kubernetes, I had to examine several related objects because each reveals a different part of the problem:

- **Pod status and readiness:** A Pod can be Running without being Ready, so both conditions needed separate checks.

- **Service endpoints:** Existing Pods do not guarantee that a Service has ready backends. I inspected the EndpointSlice separately to verify this.

- **Events instead of logs:** The container had never started, so there were no application logs. Pod events exposed the cause: `Failed to pull image ... not found`.

- **Historical events:** Older events remained visible during the investigation, including after a cluster restart. The script flagged events associated with Pods that no longer existed, so Claude had to check their timestamps and Pod names before treating them as evidence of a current failure.

- **A different recovery method:** For Nginx, I restarted the service directly. In Kubernetes, I corrected the image in the desired configuration, and the controller rolled out a replacement Pod.

**What I learned along the way:**  
Before the incident, Claude’s planning step identified probe timeouts. My probes used the default one-second timeout, which proved too short for the small Minikube node. The liveness probe failures were also contributing to backend restarts, so I increased the timeouts to five seconds.

I also observed that restarting the backend and MySQL together could cause the backend to enter a crash loop because it attempted to connect before the database was ready. This highlighted the importance of handling database readiness during application startup.

---

# Submission Instructions

Complete all tasks in sequence.

Your submission must include:
- All 13 required screenshots
- Do not expose kubeconfig contents, cluster certificates, or tokens

---

# Completion Checklist

- [✅] Task 1: Healthy baseline confirmed and workspace created (Screenshots 1–2)
- [✅] Task 2: `CLAUDE.md` safety rules added (Screenshot 3)
- [✅] Task 3: Read-only five-check plan produced before scripting (Screenshot 4)
- [✅] Task 4: Triage script built and validated (Screenshots 5–6)
- [✅] Task 5: Script run against the healthy cluster (Screenshot 7)
- [✅] Task 6: `/k8s-triage` skill built and run against the healthy baseline (Screenshots 8–9)
- [✅] Task 7: Incident simulated and correctly diagnosed without being applied (Screenshots 10–11)
- [✅] Task 8: Recovery applied by the human, verified, and summarized (Screenshots 12–13, Notes)
- [✅] No kubeconfig, tokens, or cluster credentials exposed

---

## 📌 About DMI & CloudAdvisory

DevOps Micro Internship (DMI) is a project-based DevOps program run by Pravin Mishra (The CloudAdvisory) focused on real-world execution, systems thinking, and career readiness.

It helps learners build strong DevOps foundations with hands-on experience.

---

## 📌 Resources

- 🌐 DMI Official Website: https://dmi.pravinmishra.com?utm_source=github&utm_medium=readme  
- 🎓 University: https://university.pravinmishra.com?utm_source=github&utm_medium=readme  
- 💬 Discord Community: https://discord.pravinmishra.com?utm_source=github&utm_medium=readme  
- 📝 Blog: https://dmi.pravinmishra.com/blog?utm_source=github&utm_medium=readme  
- ▶️ YouTube Playlist: https://www.youtube.com/playlist?list=PLFeSNDtI4Cho  
- 🔗 Pravin Mishra (LinkedIn): https://www.linkedin.com/in/pravin-mishra-aws-trainer/  
- 🏢 CloudAdvisory (LinkedIn): https://www.linkedin.com/company/thecloudadvisory/

---

*This submission is part of DevOps Micro Internship (DMI) — Agentic AI Track.*
