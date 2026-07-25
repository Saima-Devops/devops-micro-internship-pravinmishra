---
name: linux-triage
description: Gather Linux and Nginx health evidence from an Ubuntu server and provide an evidence-based incident analysis. This skill is read-only and must never perform recovery actions.
allowed-tools:
  - Bash
  - Read
  - Grep
disable-model-invocation: true
---

# Linux Triage Skill

## Purpose

This skill gathers operational evidence from an Ubuntu server hosting an Nginx application. It helps diagnose incidents using a read-only Bash script and follows the Agentic AI workflow:

Gather → Analyze → Human Act → Verify

---

## Safety Rules

- Never restart any service.
- Never stop any service.
- Never modify configuration files.
- Never install packages.
- Never delete files.
- Never execute recovery commands.
- Only analyze evidence collected by the Bash script.
- If evidence is insufficient, clearly state that additional investigation is required.

---

## Execution Steps

1. Run the Linux health check script:

```bash
./scripts/linux-triage.sh
```

2. Read the output.

3. Identify:
   - Overall health status
   - PASS checks
   - WARN checks
   - FAIL checks

4. Explain the most likely cause using only the collected evidence.

5. If failures exist, suggest a recovery command without executing it.

6. Recommend running the health check again after manual recovery.

---

## Output Format

Return results using this structure:

### Overall Health Status

HEALTHY | WARN | FAIL

### Evidence Collected

- Nginx Service
- Port 80
- HTTP Response
- Disk Usage
- Memory Usage

### Failed Checks

List any failed checks.

### Most Likely Cause

Provide an evidence-based diagnosis.

### Suggested Recovery Command

Provide only a suggested command, for example:

```bash
sudo systemctl start nginx
```

Do not execute it.

### Verification

Recommend rerunning:

```bash
./scripts/linux-triage.sh
```

after manual recovery.
