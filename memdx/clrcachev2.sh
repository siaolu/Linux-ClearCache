#!/usr/bin/env bash
#title          : clrcachev5.sh
#description    : Clear/flush drop_cache and swap with enhanced features
#author         : daswerks (original), (revised)
#date           : 2024-09-01
#version        : v1.0    
#==============================================================================

set -eo pipefail

# Configuration (can be overridden by environment variables)
RUNLOG="${RUNLOG:-/var/log/clrcache.log}"
DROPCACHES="${DROPCACHES:-/proc/sys/vm/drop_caches}"
FLUSH_LEVEL="${FLUSH_LEVEL:-3}"
VERBOSE="${VERBOSE:-0}"

# Function to log messages
log_message() {
    local level="$1"
    local message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "$timestamp [$level] $message" >> "$RUNLOG"
    [ "$VERBOSE" -eq 1 ] && echo "$timestamp [$level] $message"
}

# Function to handle errors
handle_error() {
    log_message "ERROR" "An error occurred in function: $1"
    log_message "ERROR" "Error message: $2"
    exit 1
}

# Trap for error handling
trap 'handle_error "${FUNCNAME}" "$BASH_COMMAND"' ERR

# Function to time other functions
time_function() {
    local start_time=$(date +%s.%N)
    "$@"
    local status=$?
    local end_time=$(date +%s.%N)
    local elapsed=$(echo "$end_time - $start_time" | bc)
    log_message "INFO" "Function '$1' took $elapsed seconds to execute"
    return $status
}

# Function to capture memory snapshot
memory_snapshot() {
    log_message "INFO" "Memory Snapshot:"
    free -m >> "$RUNLOG"
    grep -i cache /proc/meminfo >> "$RUNLOG"
}

# Clear cache
clear_cache() {
    log_message "INFO" "Clearing cache..."
    sync
    echo "$FLUSH_LEVEL" > "$DROPCACHES" || handle_error "${FUNCNAME}" "Failed to clear cache"
    log_message "INFO" "Cache cleared (level $FLUSH_LEVEL)"
}

# Clear swap
clear_swap() {
    log_message "INFO" "Clearing swap..."
    swapoff -a && swapon -a || handle_error "${FUNCNAME}" "Failed to clear swap"
    log_message "INFO" "Swap cleared"
}

# Main execution
main() {
    log_message "INFO" "=== Starting Cache Clearing Process ==="

    log_message "INFO" "Initial state:"
    time_function memory_snapshot

    time_function clear_cache
    
    log_message "INFO" "After cache clearing:"
    time_function memory_snapshot
    
    time_function clear_swap
    
    log_message "INFO" "Final state:"
    time_function memory_snapshot

    log_message "INFO" "Cache and swap clearing process completed"
}

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
   log_message "ERROR" "This script must be run as root"
   exit 1
fi

# Run main function
time_function main