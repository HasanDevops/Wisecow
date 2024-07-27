#!/bin/bash

# Configuration
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80
LOG_FILE="/path/to/system_health.log"
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# Function to log messages
log_entry() {
    echo "[$TIMESTAMP] $1" | tee -a $LOG_FILE
}

# Function to check CPU usage
check_cpu_usage() {
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    if (( $(echo "$cpu_usage > $CPU_THRESHOLD" | bc -l) )); then
        log_entry "High CPU usage detected: ${cpu_usage}%"
    else
        log_entry "CPU usage is normal: ${cpu_usage}%"
    fi
}

# Function to check memory usage
check_memory_usage() {
    memory_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    if (( $(echo "$memory_usage > $MEMORY_THRESHOLD" | bc -l) )); then
        log_entry "High memory usage detected: ${memory_usage}%"
    else
        log_entry "Memory usage is normal: ${memory_usage}%"
    fi
}

# Function to check disk usage
check_disk_usage() {
    disk_usage=$(df -h / | grep / | awk '{ print $5 }' | sed 's/%//g')
    if [ "$disk_usage" -gt "$DISK_THRESHOLD" ]; then
        log_entry "High disk usage detected: ${disk_usage}%"
    else
        log_entry "Disk usage is normal: ${disk_usage}%"
    fi
}

# Function to check number of running processes
check_running_processes() {
    process_count=$(ps aux | wc -l)
    log_entry "Number of running processes: ${process_count}"
}

# Main script execution
log_entry "System health check started."

check_cpu_usage
check_memory_usage
check_disk_usage
check_running_processes

log_entry "System health check completed."
