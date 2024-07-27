#!/bin/bash

# Configuration
SOURCE_DIR="/path/to/source/directory"
REMOTE_USER="remote_user"
REMOTE_HOST="remote_host"
REMOTE_DIR="/path/to/remote/directory"
LOG_FILE="/path/to/backup.log"
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# Create a log entry
log_entry() {
    echo "[$TIMESTAMP] $1" >> $LOG_FILE
}

# Perform backup using rsync
perform_backup() {
    rsync -avz --delete $SOURCE_DIR $REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR
    return $?
}

# Main script execution
log_entry "Backup started."

perform_backup
BACKUP_STATUS=$?

if [ $BACKUP_STATUS -eq 0 ]; then
    log_entry "Backup completed successfully."
else
    log_entry "Backup failed with status code $BACKUP_STATUS."
fi

# Report the status
if [ $BACKUP_STATUS -eq 0 ]; then
    echo "Backup completed successfully."
else
    echo "Backup failed. Check the log file for details."
fi
