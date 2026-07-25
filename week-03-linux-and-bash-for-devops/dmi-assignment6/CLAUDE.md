# Project Overview

This project is an AI-assisted Linux Incident Triage system developed as part of the DevOps Micro Internship (DMI) Cohort 3 with Agentic AI.

The project uses a read-only Bash script to collect Linux and Nginx health information from an Ubuntu server. Claude analyzes the collected evidence and assists with incident diagnosis.

The system follows an evidence-based workflow and does not perform automatic recovery actions.

# Incident Workflow

The workflow follows four phases:

1. Gather
   - Execute the linux-triage Bash script.
   - Collect evidence from the Ubuntu server.

2. Analyze
   - Review the generated evidence.
   - Identify the most likely cause.

3. Human Act
   - Suggest a recovery command only.
   - The human operator decides whether to execute it.

4. Verify
   - Run the triage script again.
   - Confirm that all health checks pass.

# Safety Rules

- Never restart any service automatically.
- Never stop any service.
- Never modify configuration files.
- Never delete files.
- Never install packages without approval.
- Never execute recovery commands automatically.
- Base every conclusion only on collected evidence.
- If evidence is insufficient, clearly state that additional investigation is required.


# Output Rules

Every incident analysis should include:

- Overall Health Status
- Evidence Collected
- Failed Checks
- Most Likely Cause
- Suggested Recovery Command
- Confidence Level
- Verification Recommendation

Clearly separate facts from assumptions.
