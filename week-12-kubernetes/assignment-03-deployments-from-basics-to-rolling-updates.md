# Assignment 3 — Deployments: From Basics to Rolling Updates

Part of the DevOps Micro Internship (DMI) with Agentic AI

---

## Purpose

In this guided lab, you will create an NGINX Deployment, add a zero-downtime RollingUpdate strategy, perform an image update, roll it back, and scale the workload.

---

# Task 1 — Set Up the Working Directory

## Goal

Create the `~/k8s-labs/deployments` working directory.

### Evidence

#### Screenshot 1 — Terminal showing the `~/k8s-labs/deployments` working directory

![alt text](screenshots/Assignment-3/Screenshot-1.png)

---

# Task 2 — Create the Basic Deployment

## Goal

Create `nginx-deployment.yaml` with two replicas and image `nginx:1.21.1`, apply it, and verify the Deployment, ReplicaSet, and Pods.

### Evidence

#### Screenshot 2 — Manifest plus `kubectl` output showing the Deployment, ReplicaSet, and two Pods

![alt text](screenshots/Assignment-3/Screenshot-2.png)
![alt text](screenshots/Assignment-3/Screenshot-3.png)


---

# Task 3 — Configure the RollingUpdate Strategy

## Goal

Add `strategy.rollingUpdate` with `maxSurge: 1` and `maxUnavailable: 0` to the Deployment and reapply it.

### Evidence

#### Screenshot 3 — Deployment YAML showing the RollingUpdate strategy and successful apply output

![alt text](screenshots/Assignment-3/Screenshot-4.png)

![alt text](screenshots/Assignment-3/Screenshot-5.png)

---

# Task 4 — Perform and Roll Back an Image Update

## Goal

Update the image to `nginx:1.23.1` with `kubectl set image`, watch the rollout, then roll it back with `kubectl rollout undo` and check rollout history.

### Evidence

#### Screenshot 4 — Rolling-update status, multiple ReplicaSets, and successful rollback/history output

![alt text](screenshots/Assignment-3/Screenshot-6.png)

![alt text](screenshots/Assignment-3/Screenshot-7.png)

## Rollback:

![alt text](screenshots/Assignment-3/Screenshot-8.png)

![alt text](screenshots/Assignment-3/Screenshot-9.png)

---

# Task 5 — Scale the Deployment

## Goal

Scale to five replicas, verify, then scale back to two.

### Evidence

#### Screenshot 5 — Terminal showing the scale-up and scale-down results

![alt text](screenshots/Assignment-3/Screenshot-10.png)

![alt text](screenshots/Assignment-3/Screenshot-11.png)

---

### Notes

Write a short note describing what the lab demonstrated.

In this lab, I created an NGINX Deployment with two replicas using the image `nginx:1.21.1` and verified the Deployment, ReplicaSet, and Pods. I configured a RollingUpdate strategy with `maxSurge: 1` and `maxUnavailable: 0`, allowing one extra Pod during updates while keeping the desired number of Pods available. I updated the image to `nginx:1.23.1`, monitored the rollout, and rolled back to the previous version using `kubectl rollout undo`. I also checked the rollout history, scaled the Deployment to five replicas, and then reduced it back to two. This lab demonstrated how Kubernetes Deployments manage replicas, controlled updates, rollbacks, and scaling.

---

# Submission Instructions

- Add all required screenshots in your submission
- Include the completed YAML manifests used in the lab

---

# Completion Checklist

- [✅] Task 1: Lab directory created (Screenshot 1)
- [✅] Task 2: Two-replica Deployment applied (Screenshot 2)
- [✅] Task 3: RollingUpdate strategy configured (Screenshot 3)
- [✅] Task 4: Image updated and rolled back (Screenshot 4)
- [✅] Task 5: Scaled up and down (Screenshot 5)
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
