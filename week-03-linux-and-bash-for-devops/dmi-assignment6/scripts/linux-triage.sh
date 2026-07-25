#!/bin/bash

# ==========================================================
# AI-Assisted Linux Health Check
# DevOps Micro Internship (DMI) Cohort 3
# Assignment 6
# ==========================================================

FULL_NAME="Saima Usman"

# -------------------------------
# Thresholds
# -------------------------------
WARN_DISK=80
FAIL_DISK=90
WARN_MEMORY=200

PASS_COUNT=0
WARN_COUNT=0
FAIL_COUNT=0
EXIT_CODE=0

# -------------------------------
# Report Header
# -------------------------------
echo "=================================================="
echo " AI-Assisted Linux Health Check Report"
echo "=================================================="
echo "Engineer : $FULL_NAME"
echo "Hostname : $(hostname)"
echo "Date     : $(date)"
echo "=================================================="
echo

# -------------------------------
# Health Checks
# -------------------------------
checks=(
check_nginx
check_port
check_http
check_disk
check_memory
)

# ==========================================================
# Check 1 - Nginx Service
# ==========================================================
check_nginx() {

    echo "[1/5] Checking Nginx Service..."

    STATUS=$(systemctl is-active nginx 2>/dev/null)

    if [ "$STATUS" = "active" ]; then
        echo "PASS : Nginx service is running."
        ((PASS_COUNT++))
    else
        echo "FAIL : Nginx service is NOT running."
        ((FAIL_COUNT++))
        EXIT_CODE=1
    fi

    echo
}

# ==========================================================
# Check 2 - Port 80
# ==========================================================
check_port() {

    echo "[2/5] Checking Port 80..."

    if ss -ltn | grep -q ":80"; then
        echo "PASS : Port 80 is listening."
        ((PASS_COUNT++))
    else
        echo "FAIL : Port 80 is not listening."
        ((FAIL_COUNT++))
        EXIT_CODE=1
    fi

    echo
}

# ==========================================================
# Check 3 - HTTP Response
# ==========================================================
check_http() {

    echo "[3/5] Checking HTTP Response..."

    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost)

    if [ "$HTTP_CODE" = "200" ]; then
        echo "PASS : HTTP Response = 200 OK"
        ((PASS_COUNT++))
    else
        echo "FAIL : HTTP Response = $HTTP_CODE"
        ((FAIL_COUNT++))
        EXIT_CODE=1
    fi

    echo
}

# ==========================================================
# Check 4 - Disk Usage
# ==========================================================
check_disk() {

    echo "[4/5] Checking Disk Usage..."

    DISK_USAGE=$(df / | awk 'NR==2 {gsub("%",""); print $5}')

    if [ "$DISK_USAGE" -ge "$FAIL_DISK" ]; then

        echo "FAIL : Disk usage is ${DISK_USAGE}%"

        ((FAIL_COUNT++))

        EXIT_CODE=1

    elif [ "$DISK_USAGE" -ge "$WARN_DISK" ]; then

        echo "WARN : Disk usage is ${DISK_USAGE}%"

        ((WARN_COUNT++))

    else

        echo "PASS : Disk usage is ${DISK_USAGE}%"

        ((PASS_COUNT++))

    fi

    echo
}

# ==========================================================
# Check 5 - Memory
# ==========================================================
check_memory() {

    echo "[5/5] Checking Available Memory..."

    FREE_MEMORY=$(free -m | awk '/Mem:/ {print $7}')

    if [ "$FREE_MEMORY" -lt "$WARN_MEMORY" ]; then

        echo "WARN : Available memory is ${FREE_MEMORY} MB"

        ((WARN_COUNT++))

    else

        echo "PASS : Available memory is ${FREE_MEMORY} MB"

        ((PASS_COUNT++))

    fi

    echo
}

# ==========================================================
# Summary
# ==========================================================
summary() {

    echo "=================================================="
    echo "              HEALTH CHECK SUMMARY"
    echo "=================================================="

    echo "Engineer : $FULL_NAME"
    echo

    echo "PASS : $PASS_COUNT"
    echo "WARN : $WARN_COUNT"
    echo "FAIL : $FAIL_COUNT"

    echo

    if [ "$FAIL_COUNT" -gt 0 ]; then

        echo "Overall Status : FAIL"

    elif [ "$WARN_COUNT" -gt 0 ]; then

        echo "Overall Status : WARN"

    else

        echo "Overall Status : HEALTHY"

    fi

    echo "=================================================="
}

# ==========================================================
# Execute Checks
# ==========================================================
for check in "${checks[@]}"
do
    $check
done

summary

exit $EXIT_CODE
