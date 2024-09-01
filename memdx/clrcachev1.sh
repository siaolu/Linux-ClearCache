#!/bin/bash

# Set up variables
LOGDIR="$HOME/myscripts"
LOGFILE="$LOGDIR/free-mem.sh.log"
DATE=$(date "+%Y-%m-%d %H:%M:%S")

# Ensure log directory exists
mkdir -p "$LOGDIR"

# Function to log messages
log_message() {
    echo "$1" >> "$LOGFILE"
}

# Start logging
log_message "============================ $DATE =================================="
log_message "Your Server Free Memory Script"

# Sync filesystems
log_message "Syncing filesystems..."
sync
sync_result=$?
log_message "Sync result: $sync_result"

# Drop caches (requires root privileges)
log_message "Attempting to free drop caches..."
if sudo -n true 2>/dev/null; then
    echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null
    drop_caches_result=$?
    log_message "Drop caches result: $drop_caches_result"
else
    log_message "Error: Root privileges required to drop caches. Skipping this step."
fi

# Log memory information
log_message "Memory information (in MB):"
free -m >> "$LOGFILE"

log_message "Script completed."