#!/bin/sh

## Reference : https://www.tecmint.com/clear-ram-memory-cache-buffer-and-swap-space-on-linux/

### StringSubSetups
runlog=/var/log/log.clrcache
dcach="/proc/sys/vm/drop_caches"
sycho="sync; echo "
so="sudo"
vms=" vmstat"
vmo=" -a -m -w -n "
vmg="| grep cache"

function log_header () {
    echo "=== $DATE ===" >> $runlog
}

function log_vmstats () {      #Dump vmstat data to log
    $so $vms $vmo$vmg >> $runlog
    free -g >> $runlog
}

function xcache () {            #Clear cache
    sync
    $sycho1 > $dcache
    $sycho2 > $dcache
    $sycho3 > $dcache
}

function bncSwap() {
  swapoff -a && swapon -a
}

function log_end {
  echo "---Cache cleared" >> $runlog
}

function do_main () {
    log_header
    xcache
    bncSwap
    log_vmstats
    log_end

}

do_main
