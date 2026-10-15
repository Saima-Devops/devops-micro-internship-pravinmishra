# Assignment 7 — Kubernetes Services (ClusterIP)

Part of the DevOps Micro Internship (DMI) with Agentic AI

---

## Purpose

In this guided lab, you will create an internal ClusterIP Service for NGINX, call it by DNS and virtual IP, break and fix its selector, and prove readiness-aware endpoint routing.

---

# Task 1 — Deploy the Probed NGINX Workload

## Goal

Create two healthy, labeled NGINX Pods (readiness + liveness probes) as Service backends.

### Evidence

#### Screenshot 1 — Two Ready Pods with labels and IPs

![alt text](screenshots/Assignment-7/Screenshot-1.png)

---

# Task 2 — Create and Inspect the ClusterIP Service

## Goal

Create `nginx-svc` (type `ClusterIP`, selector `app: nginx`, port 80) and inspect the Service, Endpoints, and EndpointSlices.

### Evidence

#### Screenshot 2 — Service ClusterIP plus populated Endpoints and EndpointSlices

![alt text](screenshots/Assignment-7/Screenshot-2.png)

![alt text](screenshots/Assignment-7/Screenshot-3.png)

---

# Task 3 — Call the Service from a Client Pod

## Goal

Create a BusyBox `tester` Pod and call `nginx-svc` by short name, ClusterIP, and both short/FQDN via `nslookup`.

### Evidence

#### Screenshot 3 — Successful `wget` responses and `nslookup` output

![alt text](screenshots/Assignment-7/Screenshot-4.png)

![alt text](screenshots/Assignment-7/Screenshot-5.png)

---

# Task 4 — Break and Fix the Selector Contract

## Goal

Change the Service selector to `app: does-not-match`, confirm endpoints become empty and requests fail, then restore `app: nginx`.

### Evidence

#### Screenshot 4 — Empty endpoints during failure and restored endpoints after the fix

![alt text](screenshots/Assignment-7/Screenshot-6.png)

![alt text](screenshots/Assignment-7/Screenshot-7.png)

![alt text](screenshots/Assignment-7/Screenshot-8.png)

![alt text](screenshots/Assignment-7/Screenshot-9.png)

![alt text](screenshots/Assignment-7/Screenshot-10.png)

---

# Task 5 — Prove Readiness-Aware Routing

## Goal

Scale to one replica, apply a broken readiness patch, confirm the NotReady Pod is excluded from Service endpoints, then restore the healthy Deployment.

### Evidence

#### Screenshot 5 — NotReady Pod with excluded endpoint, followed by restored endpoint membership

![alt text](screenshots/Assignment-7/Screenshot-11.png)
![alt text](screenshots/Assignment-7/Screenshot-12.png)
![alt text](screenshots/Assignment-7/Screenshot-13.png)
![alt text](screenshots/Assignment-7/Screenshot-14.png)
![alt text](screenshots/Assignment-7/Screenshot-15.png)
![alt text](screenshots/Assignment-7/Screenshot-16.png)
![alt text](screenshots/Assignment-7/Screenshot-17.png)

---

# Task 6 — Troubleshoot and Optionally Clean Up

## Goal

Verify the Service path, then optionally delete `tester` and `nginx-svc`.

### Evidence

#### Screenshot 6 — Final verification or optional cleanup output

![alt text](screenshots/Assignment-7/Screenshot-18.png)

### Clean Up

![alt text](screenshots/Assignment-7/Screenshot-19.png)

---

### Notes

Write a short note describing what the lab demonstrated.

In this lab, I deployed two NGINX Pods with readiness and liveness probes and created an internal ClusterIP Service named `nginx-svc`. I inspected its ClusterIP, Endpoints, and EndpointSlices, then verified access by Service DNS name and virtual IP from a BusyBox tester Pod. I also checked DNS resolution using `nslookup`.

Changing the Service selector to `app: does-not-match` removed its backend endpoints and caused requests to fail. Restoring `app: nginx` restored connectivity. I then demonstrated readiness-aware routing by breaking the readiness probe and confirming that the NotReady Pod was excluded from ready Service endpoints. Restoring the healthy configuration made the backend available again. This lab demonstrated how ClusterIP Services provide stable internal access through DNS, label selectors, and readiness-aware routing.

---

# Submission Instructions

- Add all required screenshots in your submission
- Include the completed YAML manifests used in the lab

---

# Completion Checklist

- [✅] Task 1: Probed NGINX Deployment applied (Screenshot 1)
- [✅] Task 2: ClusterIP Service created and inspected (Screenshot 2)
- [✅] Task 3: Service reached by DNS and ClusterIP (Screenshot 3)
- [✅] Task 4: Selector broken and fixed (Screenshot 4)
- [✅] Task 5: Readiness-aware routing proven (Screenshot 5)
- [✅] Task 6: Verified / cleaned up (Screenshot 6)
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
