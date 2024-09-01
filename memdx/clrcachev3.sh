#!/usr/bin/env bash
#title          : clrcachev6.sh
#description    : Clear/flush drop_cache and swap with enhanced features and testing
#author         : sia-emff (original), Assistant (revised)
#date           : 2023-09-01
#version        : v0.6    
#==============================================================================

set -eo pipefail

# Configuration (can be overridden by environment variables)
RUNLOG="${RUNLOG:-/var/log/clrcache.log}"
DROPCACHES="${DROPCACHES:-/proc/sys/vm/drop_caches}"
FLUSH_LEVEL="${FLUSH_LEVEL:-3}"
VERBOSE="${VERBOSE:-0}"
TEST_MODE="${TEST_MODE:-0}"

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
    if [ "$TEST_MODE" -eq 0 ]; then
        echo "$FLUSH_LEVEL" > "$DROPCACHES" || handle_error "${FUNCNAME}" "Failed to clear cache"
    else
        log_message "TEST" "Simulating cache clear with level $FLUSH_LEVEL"
    fi
    log_message "INFO" "Cache cleared (level $FLUSH_LEVEL)"
}

# Clear swap
clear_swap() {
    log_message "INFO" "Clearing swap..."
    if [ "$TEST_MODE" -eq 0 ]; then
        swapoff -a && swapon -a || handle_error "${FUNCNAME}" "Failed to clear swap"
    else
        log_message "TEST" "Simulating swap clear"
    fi
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

# Test functions
test_log_message() {
    log_message "TEST" "Testing log_message function"
    [ -f "$RUNLOG" ] || handle_error "${FUNCNAME}" "Log file not created"
    grep -q "Testing log_message function" "$RUNLOG" || handle_error "${FUNCNAME}" "Log message not written"
    log_message "TEST" "log_message function test passed"
}

test_memory_snapshot() {
    memory_snapshot
    grep -q "Mem:" "$RUNLOG" || handle_error "${FUNCNAME}" "Memory snapshot not captured"
    grep -q "Cache" "$RUNLOG" || handle_error "${FUNCNAME}" "Cache info not captured"
    log_message "TEST" "memory_snapshot function test passed"
}

test_clear_cache() {
    local initial_cached=$(grep -i "cached" /proc/meminfo | awk '{print $2}')
    clear_cache
    local after_cached=$(grep -i "cached" /proc/meminfo | awk '{print $2}')
    [ "$initial_cached" -gt "$after_cached" ] || handle_error "${FUNCNAME}" "Cache not cleared effectively"
    log_message "TEST" "clear_cache function test passed"
}

test_clear_swap() {
    clear_swap
    local swap_used=$(free | grep Swap | awk '{print $3}')
    [ "$swap_used" -eq 0 ] || handle_error "${FUNCNAME}" "Swap not cleared effectively"
    log_message "TEST" "clear_swap function test passed"
}

run_tests() {
    log_message "TEST" "Starting test suite"
    test_log_message
    test_memory_snapshot
    TEST_MODE=0  # Temporarily disable test mode for actual cache and swap clearing
    test_clear_cache
    test_clear_swap
    TEST_MODE=1  # Re-enable test mode
    log_message "TEST" "All tests passed successfully"
}

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
   log_message "ERROR" "This script must be run as root"
   exit 1
fi

# Parse command line arguments
while getopts "vt" opt; do
    case ${opt} in
        v )
            VERBOSE=1
            ;;
        t )
            TEST_MODE=1
            ;;
        \? )
            echo "Usage: $0 [-v] [-t]"
            echo "  -v: Verbose mode"
            echo "  -t: Test mode"
            exit 1
            ;;
    esac
done

# Run tests or main function
if [ "$TEST_MODE" -eq 1 ]; then
    run_tests
else
    time_function main
fi