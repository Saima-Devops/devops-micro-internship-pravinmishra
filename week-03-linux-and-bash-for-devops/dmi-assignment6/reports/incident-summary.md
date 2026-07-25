# Incident Summary

**Full Name:** Saima Usman

**Date:** 25/07/2026

## 1. Reported Symptom

The hosted React application became inaccessible because the Nginx service was intentionally stopped during the incident simulation.

## 2. Evidence Collected

- Nginx service status
- Port 80 listening status
- HTTP response from localhost
- Disk usage
- Available memory
- Linux triage report

## 3. Most Likely Cause

The Nginx service was inactive, preventing the web server from accepting HTTP requests on port 80.

## 4. Human-Approved Recovery Action

The Nginx service was manually restarted using:

```bash
sudo systemctl start nginx
```

## 5. Verification

The recovery was verified by confirming:

- Nginx status: active
- Port 80 listening
- HTTP 200 OK response
- All five health checks passed
- Overall status: HEALTHY

## 6. Safety Decision

Claude analyzed the collected evidence and suggested a recovery command but did not execute any changes. The recovery was performed manually by the human operator.

## 7. Agentic Loop Mapping

- **Gather:** Bash triage script collected Linux and Nginx health information.
- **Analyze:** Claude interpreted the evidence and identified the likely cause.
- **Human Act:** The Nginx service was manually restarted.
- **Verify:** The Bash script confirmed successful recovery with all checks passing.
