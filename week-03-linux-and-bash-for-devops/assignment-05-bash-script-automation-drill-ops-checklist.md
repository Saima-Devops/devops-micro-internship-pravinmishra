# Assignment 5 — Bash Script Automation Drill (OPS Checklist)

Part of the DevOps Micro Internship (DMI) Cohort 3 with Agentic AI

---

## Purpose

In this assignment, you will practice Bash scripting by building a series of small automation scripts covering environment setup, variables, arrays, loops, file conditionals, if-else logic, and functions. These scripts form the foundation of real-world Linux automation used in DevOps, cloud, and production support environments.

---

# Task 1 — Bash Environment & Workspace Setup

## Goal

Verify that Bash is available on your system and create a clean workspace for this assignment.

### Evidence

#### Screenshot 1 — Output of `echo $SHELL` and `bash --version`

![alt text](screenshots/assign5-img1.png)

---

#### Screenshot 2 — Output of `pwd` and `ls -lah` showing the scripts directory

![alt text](screenshots/assign5-img2.png)

---

### Notes

Answer the following in your own words:

**1. What is Bash?**

Bash (Bourne Again SHell) is a command-line interpreter used to interact with Linux and Unix operating systems. It allows users to execute commands and automate tasks using shell scripts.

---

**2. What is the difference between shell and Bash?**

A shell is a program that allows users to communicate with the operating system. Bash is one specific type of shell that provides many additional features such as scripting, command history, and tab completion.

---

**3. Why is it important to confirm the Bash version before writing scripts?**

Different Bash versions support different features. Confirming the version ensures that the script will work correctly on the current system.

---

# Task 2 — Your First Bash Script

## Goal

Create your first Bash script, make it executable, and run it from the terminal.

### Evidence

#### Screenshot 1 — Content of `first-script.sh`

![alt text](screenshots/assign5-img3a.png)

---

#### Screenshot 2 — Output of `./first-script.sh`

![alt text](screenshots/assign5-img3.png)

---

#### Screenshot 3 — Output of `ls -l first-script.sh` showing executable permission

![alt text](screenshots/assign5-img3b.png)

---

### Notes

Answer the following in your own words:

**1. What is the purpose of `#!/bin/bash`?**

It tells the operating system to execute the script using the Bash interpreter.

---

**2. Why do we use `chmod +x` before running a script?**

It gives the script execute permission so it can be run directly.

---

**3. What is the difference between running a script using `./script.sh` and `bash script.sh`?**

./script.sh executes the script directly and requires execute permission. bash script.sh runs the script using Bash and does not require execute permission.

---

# Task 3 — Variables: User Information Script

## Goal

Use variables to store and display user-related information.

### Evidence

#### Screenshot 1 — Content of `user-info.sh`

![alt text](screenshots/assign5-img4a.png)

---

#### Screenshot 2 — Output of `./user-info.sh`

![alt text](screenshots/assign5-img4.png)

---

### Notes

Answer the following in your own words:

**1. What is a variable in Bash?**

A variable is a named storage location used to hold data that can be used throughout a script.

---

**2. Why should we avoid spaces around the `=` sign when creating variables?**

Spaces make Bash interpret the statement incorrectly, resulting in a syntax error.

---

**3. How do you access the value stored inside a Bash variable?**

By using the dollar sign ($) before the variable name. Example: echo $name

---

# Task 4 — Arrays & Loops: Tools Checklist Script

## Goal

Use arrays and loops to print a checklist of tools used in Bash scripting.

### Evidence

#### Screenshot 1 — Content of `tools-checklist.sh`

![alt text](screenshots/assign5-img5a.png)

---

#### Screenshot 2 — Output of `./tools-checklist.sh`

![alt text](screenshots/assign5-img5.png)

---

### Notes

Answer the following in your own words:

**1. What is an array in Bash?**

An array is a collection of multiple values stored under one variable name.

---

**2. Why are arrays useful in scripts?**

Arrays make scripts easy to manage multiple related values without creating many separate variables.

---

**3. What does `"${tools[@]}"` mean?**

It represents all elements stored in the tools array.

---

**4. What is the purpose of the `for` loop in this script?**

The for loop repeats a block of code for every item in the array.

---

# Task 5 — Loops: Number Counter Script

## Goal

Use loops to repeat a task multiple times.

### Evidence

#### Screenshot 1 — Content of `counter.sh`

![alt text](screenshots/assign5-img6a.png)

---

#### Screenshot 2 — Output of `./counter.sh`

![alt text](screenshots/assign5-img6.png)
---

### Notes

Answer the following in your own words:

**1. What is a loop?**

A loop repeatedly executes a block of code until a condition is met.

---

**2. Why do we use loops in Bash scripting?**

We use loops in bash scripting beacuse loops automate repetitive tasks and reduce duplicate code.

---

**3. How many times did the loop run in your script?**

Five times.

---

**4. What would you change if you wanted the loop to run 10 times?**

Change:

```
{1..5}
```

to

```
{1..10}
```

---

# Task 6 — Files & Conditionals: File Validation Script

## Goal

Use file checks and conditionals to verify whether files and directories exist.

### Evidence

#### Screenshot 1 — Output of `ls -lah ../test-folder`

![alt text](screenshots/assign5-img7a.png)

---

#### Screenshot 2 — Content of `file-check.sh`

![alt text](screenshots/assign5-img7b.png)
---

#### Screenshot 3 — Output of `./file-check.sh`



![alt text](screenshots/assign5-img7.png)

---

### Notes

Answer the following in your own words:

**1. What does `-d` check in Bash?**

It checks whether the specified path is an existing directory.

---

**2. What does `-f` check in Bash?**

It checks whether the specified path is an existing regular file.

---

**3. Why should file and directory paths be stored in variables?**

Using variables makes scripts easier to read, maintain, and update because the path only needs to be changed in one place.

---

**4. What happens if the file does not exist?**

The condition evaluates to false, and the script executes the else block.

---

# Task 7 — Conditionals: Pass or Retry Script

## Goal

Use if-else conditionals to make decisions based on a variable value.

### Evidence

#### Screenshot 1 — Content of `score-check.sh` with `score=85`

![alt text](screenshots/assign5-img8a.png)

---

#### Screenshot 2 — Output showing `Result: Pass`

![alt text](screenshots/assign5-img8b.png)

---

#### Screenshot 3 — Content of `score-check.sh` with `score=55`

![alt text](screenshots/assign5-img8d.png)

---

#### Screenshot 4 — Output showing `Result: Retry`

![alt text](screenshots/assign5-img8c.png)

---

### Notes

Answer the following in your own words:

**1. What is the purpose of if-else in Bash?**

It allows the script to make decisions and execute different code based on whether a condition is true or false.

---

**2. What does `-ge` mean?**

It means "greater than or equal to."

---

**3. Why should conditions be tested with different values?**

Testing different values ensures that both the true and false branches work correctly.

---

**4. How can conditionals help in automation scripts?**

Conditionals allow automation scripts to respond differently depending on system status, user input, or file existence.

---

# Task 8 — Functions: Final Bash Automation Script

## Goal

Create a final Bash script using functions to organize reusable code.

### Evidence

#### Screenshot 1 — Content of `final-automation.sh`

![alt text](screenshots/assign5-img10a.png)

---

#### Screenshot 2 — Output of `./final-automation.sh`

![alt text](screenshots/assign5-img10b.png)

---

#### Screenshot 3 — Output of `ls -lah` showing all created scripts

![alt text](screenshots/assign5-img11.png)

---

### Notes

Answer the following in your own words:

**1. What is a function in Bash?**

A function is a reusable block of code that performs a specific task and can be called multiple times.

---

**2. Why are functions useful in scripts?**

Functions improve code organization, reduce repetition, and make scripts easier to maintain.
---

**3. Which functions did you create in this script?**

I created show_user, show_tools, check_directory, and main.

---

**4. How does this final script combine variables, arrays, loops, conditionals, files, and functions?**

The script uses variables to store user information, an array to store tool names, a loop to display each tool, a conditional to check whether a directory exists, and functions to organize the code into reusable sections.

---

# LinkedIn Post (Required)

## Evidence

#### LinkedIn Post URL

https://tinyurl.com/38kkcdkm

<<<<<<< HEAD:week-03-linux-for-devops/assignment-05-bash-script-automation-drill-ops-checklist.md
`________________________`
=======
`Add your URL here`
>>>>>>> upstream/main:week-03-linux-and-bash-for-devops/assignment-05-bash-script-automation-drill-ops-checklist.md

---

#### Screenshot — Published LinkedIn post

![alt text](screenshots/assign5-img12.png)


---

# Submission Instructions

- Add all required screenshots in your submission
- Full name must be visible in required screenshots
- All script files must be created and run successfully
- Required notes must be answered clearly for every task
- Do not expose sensitive information (keys, passwords, credentials)

---

# Completion Checklist

- [✔️] Task 1: Environment setup verified, workspace created (Screenshots 1–2, Notes answered)
- [✔️] Task 2: First script created, executed, permissions verified (Screenshots 1–3, Notes answered)
- [✔️] Task 3: Variables script created and run (Screenshots 1–2, Notes answered)
- [✔️] Task 4: Arrays and loops script created and run (Screenshots 1–2, Notes answered)
- [✔️] Task 5: Counter loop script created and run (Screenshots 1–2, Notes answered)
- [✔️] Task 6: File validation script created and run (Screenshots 1–3, Notes answered)
- [✔️] Task 7: Pass/Retry conditional script tested with both values (Screenshots 1–4, Notes answered)
- [✔️] Task 8: Final automation script created and run (Screenshots 1–3, Notes answered)
- [✔️] All scripts run without errors
- [✔️] Full Name visible in all required screenshots
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