#!/bin/sh

### StringSubSetups
runlog=/var/log/log.clrcache
dcach="/proc/sys/vm/drop_caches"
sycho="sync; echo "
tdate=$(date)
so="sudo"
vms=" vmstat"
vmo=" -a -m -w -n "
vmg="| grep cache"

function log_header {
    echo "=== $tdate ===" >> $runlog
}

function log_vmstats {      #Dump vmstat data to log
    $so $vms $vmo$vmg >> $runlog
    free -g >> $runlog
}

function xcache {            #Clear cache
    sync
    $sycho1 > $dcache
    $sycho2 > $dcache
    $sycho3 > $dcache
}

function bncSwap {            #Clear Swap - Caution see Readme.md
  swapoff -a && swapon -a
}

function log_end {
  echo "---Cache cleared" >> $runlog
}

function exec_main {
    log_header
    xcache
    bncSwap
    log_vmstats
    log_end
}

exec_main
