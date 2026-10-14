# Assignment 4 — Auto-Scaling & Auto-Healing: Let Kubernetes React for You

Part of the DevOps Micro Internship (DMI) with Agentic AI

---

## Purpose

In this guided lab, you will prove Deployment auto-healing by deleting a Pod, then configure a CPU-based Horizontal Pod Autoscaler that maintains between two and five NGINX Pods.

---

# Task 1 — Set Up the Lab Directory

## Goal

Create the `~/k8s-labs/autoscaling` working directory.

### Evidence

#### Screenshot 1 — Terminal showing the `autoscaling` directory

![alt text](screenshots/Assignment-4/Screenshot-1.png)

---

# Task 2 — Prove Deployment Auto-Healing

## Goal

Create `demo-autohealing` (two replicas), delete one Pod, and confirm the desired count of two is restored automatically.

### Evidence

#### Screenshot 2 — Deleted Pod and replacement Pod with the replica count restored

![alt text](screenshots/Assignment-4/Screenshot-2.png)

![alt text](screenshots/Assignment-4/Screenshot-3.png)

---

# Task 3 — Create the HPA-Ready Deployment and Enable Metrics

## Goal

Deploy `nginx-deployment` with CPU `requests: 100m` / `limits: 200m`, then enable Metrics Server (Minikube addon or manifest + kubelet TLS patch for kind) and confirm it reports `READY 1/1`.

### Evidence

#### Screenshot 3 — Deployment resources plus successful Metrics Server status

![alt text](screenshots/Assignment-4/Screenshot-4.png)

![alt text](screenshots/Assignment-4/Screenshot-5.png)

![alt text](screenshots/Assignment-4/Screenshot-6.png)

---

# Task 4 — Create and Inspect the HPA

## Goal

Create an HPA (imperatively via `kubectl autoscale` or declaratively via `autoscaling/v2`) targeting `nginx-deployment` with min 2, max 5, and 50% target CPU utilization.

### Evidence

#### Screenshot 4 — `kubectl get hpa` and `kubectl describe hpa nginx-hpa` output

#### Method#1: Imperative

![alt text](screenshots/Assignment-4/Screenshot-7.png)

#### Method#2: Declarative (production style)

![alt text](screenshots/Assignment-4/Screenshot-8.png)

![alt text](screenshots/Assignment-4/Screenshot-9.png)


---

# Task 5 — Optionally Generate CPU Load

## Goal

Generate CPU load inside an NGINX Pod (`yes > /dev/null`) and monitor whether the HPA increases replicas.

### Evidence

#### Screenshot 5 — HPA output showing current metrics and any replica increase

![alt text](screenshots/Assignment-4/Screenshot-11.png)

![alt text](screenshots/Assignment-4/Screenshot-10.png)

---

### Notes

Write a short note describing what the lab demonstrated.

In this lab, I demonstrated Kubernetes auto-healing by deleting one Pod and observing a replacement restore the Deployment to two replicas. I configured NGINX with CPU requests of `100m` and limits of `200m`, enabled Metrics Server, and created an HPA with a minimum of two replicas, a maximum of five, and a target CPU utilization of 50%.

After generating CPU load, I monitored the HPA using `kubectl get hpa -w`. CPU utilization reached 100%, exceeding the 50% target, and the replica count automatically increased from two to four. CPU utilization later dropped to 0%, while four replicas remained at the end of the observation. This lab demonstrated how Kubernetes replaces missing Pods and automatically scales workloads in response to CPU demand.

---

# Submission Instructions

- Add all required screenshots in your submission
- Include the completed YAML manifests used in the lab

---

# Completion Checklist

- [✅] Task 1: Lab directory created (Screenshot 1)
- [✅] Task 2: Auto-healing observed (Screenshot 2)
- [✅] Task 3: HPA-ready Deployment applied and Metrics Server verified (Screenshot 3)
- [✅] Task 4: HPA created and inspected (Screenshot 4)
- [✅] Task 5: CPU load generated and scaling observed (Screenshot 5, optional)
- [✅] Reflection notes written (Notes)

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
