# Assignment 6 — Deploy the Book Review App with Docker Compose

Part of the DevOps Micro Internship (DMI) with Agentic AI

---

## Purpose

In this assignment, you will deploy the Book Review Application with Docker Compose using MySQL, a backend API, and a frontend user interface. You will configure health-gated startup, browser-facing API access, CORS, and persistent MySQL storage.

---

# Task 1 — Prepare the Project

## Goal

Prepare your fork of the Book Review App repository for Docker Compose deployment.

### Evidence

#### Screenshot 1 — Project Structure

Add a screenshot showing the project structure containing:

```text
frontend/
backend/
.env.example
.gitignore
docker-compose.yml
```

![alt text](screenshots/Assignment-06/Screenshot-1.png)

---

#### Screenshot 2 — Environment and Docker Ignore Files

Add a screenshot showing the contents of:

```text
.env.example
.gitignore
frontend/.dockerignore
backend/.dockerignore
```

Ensure that no real passwords, tokens, or secrets are visible.

![alt text](screenshots/Assignment-06/Screenshot-2.png)

![alt text](screenshots/Assignment-06/Screenshot-3.png)

---

# Task 2 — Create or Confirm Application Dockerfiles

## Goal

Prepare Dockerfiles for the frontend and backend services and build both services through Docker Compose.

### Evidence

#### Screenshot 3 — Frontend Dockerfile

Add a screenshot showing the completed `frontend/Dockerfile`.

![alt text](screenshots/Assignment-06/Screenshot-4.png)

---

#### Screenshot 4 — Backend Dockerfile

Add a screenshot showing the completed `backend/Dockerfile`.

![alt text](screenshots/Assignment-06/Screenshot-5.png)

---

#### Screenshot 5 — Docker Compose Build

Add a screenshot of the terminal showing successful completion of:

```bash
docker compose build
```

![alt text](screenshots/Assignment-06/Screenshot-7.png)

---

# Task 3 — Create the Docker Compose Stack

## Goal

Create one `docker-compose.yml` file that builds and runs MySQL, backend, and frontend services.

### Evidence

#### Screenshot 6 — MySQL Service, Health Check, and Volume Mount

Add a screenshot showing the MySQL service in `docker-compose.yml`, including:

- MySQL image
- Environment variables
- MySQL health check
- `mysql_data` volume mount
- No published MySQL port

![alt text](screenshots/Assignment-06/Screenshot-9.png)

![alt text](screenshots/Assignment-06/Screenshot-10.png)

---

#### Screenshot 7 — Backend Configuration

Add a screenshot showing the backend service configuration, including:

- `depends_on` with `condition: service_healthy`
- Database host set to `mysql`
- Browser frontend origin configured for CORS
- Published backend port

![alt text](screenshots/Assignment-06/Screenshot-11.png)

---

#### Screenshot 8 — Frontend Configuration

Add a screenshot showing the frontend service configuration, including:

- Published frontend port
- `depends_on` for the backend service
- Browser-facing `NEXT_PUBLIC_API_URL`

![alt text](screenshots/Assignment-06/Screenshot-12.png)

---

#### Screenshot 9 — Named Volume Definition

Add a screenshot showing the `mysql_data` volume definition in `docker-compose.yml`.

![alt text](screenshots/Assignment-06/volume.png)

---

# Task 4 — Start and Verify the Stack

## Goal

Build and start all services through one Docker Compose workflow.

### Evidence

#### Screenshot 10 — Docker Compose Service Status

Add a screenshot of the terminal showing:

```bash
docker compose ps
```

The output must show the MySQL, backend, and frontend services running. MySQL must show as healthy.

![alt text](screenshots/Assignment-06/Screenshot-14.png)

---

#### Screenshot 11 — MySQL and Backend Logs

Add a screenshot of the terminal showing:

```bash
docker compose logs mysql backend --tail=50
```

The logs must show MySQL readiness and successful backend database connection.

![alt text](screenshots/Assignment-06/Screenshot-13.png)

---

# Task 5 — Test End-to-End Application Functionality

## Goal

Verify that the Book Review App works through the browser.

### Evidence

#### Screenshot 12 — Successful Registration or Login

Add a browser screenshot showing successful user registration or login.

Add your full name as a clear caption directly below the screenshot.

![alt text](screenshots/Assignment-06/Register.png)

![alt text](screenshots/Assignment-06/Register-2.png)

![alt text](screenshots/Assignment-06/login.png)

![alt text](screenshots/Assignment-06/homepg01.png)

---

#### Screenshot 13 — Created Book Review

Add a browser screenshot showing a created book review visible in the application.

Add your full name as a clear caption directly below the screenshot.

![alt text](screenshots/Assignment-06/homepg02.png)

![alt text](screenshots/Assignment-06/book-review.png)

![alt text](screenshots/Assignment-06/review-submitted.png)

---

#### Screenshot 14 — CORS Verification

Add a browser developer-tools screenshot with:

- The Network tab showing a successful API request
- The Console drawer showing no CORS error after the API interaction

![alt text](screenshots/Assignment-06/Screenshot-15.png)

---

# Task 6 — Prove MySQL Data Persistence

## Goal

Verify that MySQL data remains after a non-destructive Docker Compose down/up cycle.

### Evidence

#### Screenshot 15 — Data Before Restart

Add a browser screenshot showing the registered user or created review before the down/up cycle.

Add your full name as a clear caption directly below the screenshot.

![alt text](screenshots/Assignment-06/review-before-teardown.png)

---

#### Screenshot 16 — Non-Destructive Stack Restart

Add a screenshot of the terminal showing the non-destructive shutdown and restart:

```bash
docker compose down
docker compose up -d
docker compose ps
```

Do not use `docker compose down -v`.

![alt text](screenshots/Assignment-06/Screenshot-16.png)

---

#### Screenshot 17 — Data After Restart

Add a browser screenshot showing the same registered user or review after the stack restarts.

Add your full name as a clear caption directly below the screenshot.

![alt text](screenshots/Assignment-06/Screenshot-17.png)

![alt text](screenshots/Assignment-06/Screenshot-18.png)

**Clean-Up**

![alt text](screenshots/Assignment-06/Screenshot-19.png)

---

# Task 7 — Explain Docker Compose Teardown Modes

## Goal

Explain the difference between preserving data and fully resetting a Docker Compose environment.

### Notes

Write a short explanation of 5–8 lines covering:

- What `docker compose down` removes and preserves
- Why named volumes should be kept when preserving MySQL data
- What happens when named volumes are removed
- When a full reset is useful
- Why a full reset must not be used before persistence evidence is captured

`docker compose down` removes the project’s containers and networks while preserving named volumes and images. 

Keeping the `mysql_data` volume preserves MySQL accounts, books, and reviews across container recreation.  

Starting the stack again reconnects MySQL to the existing data stored in that volume.  

`docker compose down -v` also removes the project’s named volumes, deleting the stored database data.  

A full reset is useful for testing first-time initialization or clearing disposable development data.  

Capture persistence evidence before a full reset, because deleting the volume prevents proving that existing data survives a restart.

---

# Final Public Frontend URL

**Frontend URL:** `http://16.4.68.128:3000`

Replace the placeholder with your working application URL.

---

# GitHub Repository URL

**Your Fork or Repository URL:** https://github.com/Saima-Devops/Book-Review-App

---

# LinkedIn Requirement

## Goal

Create a LinkedIn post about the Book Review App deployment and what you learned from using Docker Compose.

### Evidence

**LinkedIn Post URL:** https://lnkd.in/p/eCPArVbh

#### LinkedIn Post Screenshot

![alt text](screenshots/Assignment-06/linkedin-post.png)

---

# Submission Checklist

- [✅] Book Review App repository forked and used
- [✅] `.env` excluded from Git tracking
- [✅] `.env.example` contains only safe placeholder values
- [✅] Frontend and backend Dockerfiles created or confirmed
- [✅] MySQL health check configured
- [✅] Backend waits for healthy MySQL
- [✅] Backend uses `mysql` as the database hostname
- [✅] Frontend API URL uses the VM public IP and backend port
- [✅] Backend CORS origin matches the frontend origin
- [✅] MySQL port 3306 is not publicly exposed
- [✅] Registration and login work
- [✅] Book review creation works
- [✅] Data persists after a non-destructive down/up cycle
- [✅] Screenshots 1–17 included
- [✅] Teardown explanation completed
- [✅] Public frontend URL included
- [✅] GitHub repository URL included
- [✅] LinkedIn post URL and screenshot included
- [✅] Full name visible in required terminal screenshots
- [✅] Browser screenshots include a full-name caption
- [✅] No sensitive information exposed

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
