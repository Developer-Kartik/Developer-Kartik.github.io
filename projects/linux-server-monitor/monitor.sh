
#!/bin/bash


# Error handling
set -o pipefail

# Required commands
for cmd in hostname date uptime top free df ps awk tee; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "ERROR: Required command '$cmd' is missing."
        exit 1
    fi
done

# Timestamped logging
LOG_DIR="./logs"
LOG_FILE="$LOG_DIR/server-monitor.log"

mkdir -p "$LOG_DIR" || {
    echo "ERROR: Cannot create log directory."
    exit 1
}

# Linux Server Monitoring Tool

LOG_DIR="./logs"
LOG_FILE="$LOG_DIR/server-monitor.log"
DISK_THRESHOLD=80

mkdir -p "$LOG_DIR"

{
    echo "========================================"
    echo "       LINUX SERVER MONITOR"
    echo "========================================"

    echo "Date: $(date)"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"

    echo ""
    echo "CPU INFORMATION"
    top -bn1 | grep "Cpu(s)"

    echo ""
    echo "MEMORY INFORMATION"
    free -h

    echo ""
    echo "DISK UTILIZATION"
    df -h

    echo ""
    echo "DISK USAGE ALERTS"

    df -P | awk -v threshold="$DISK_THRESHOLD" '
    NR > 1 {
        usage = $5
        gsub("%", "", usage)

        if (usage >= threshold) {
            print "WARNING: " $6 " is at " usage "% usage"
        }
    }'

    echo ""
    echo "TOP 5 CPU PROCESSES"
    ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -6

    echo ""

echo ""
echo "RESOURCE ALERTS"

# CPU usage calculation
CPU_USAGE=$(top -bn1 | awk -F'[, ]+' '/Cpu\(s\)/ {
    for (i=1; i<=NF; i++) {
        if ($i == "id") {
            print 100-$(i-1)
            exit
        }
    }
}')

# RAM usage calculation
MEMORY_USAGE=$(free | awk '/Mem:/ {
    if ($2 > 0) printf "%.0f", ($3/$2)*100
}')

echo "CPU Usage: ${CPU_USAGE}%"
echo "Memory Usage: ${MEMORY_USAGE}%"

if (( $(echo "$CPU_USAGE >= 80" | bc -l) )); then
    echo "WARNING: High CPU usage detected!"
fi

if [ "$MEMORY_USAGE" -ge 80 ]; then
    echo "WARNING: High memory usage detected!"
fi

    echo "MONITORING COMPLETED"
    echo "========================================"

} | tee -a "$LOG_FILE"
