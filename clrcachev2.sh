#!/bin/sh

### StringSubSetups
runlog=/var/log/log.clrcache

dropcaches="/proc/sys/vm/drop_caches"
# Adjust per your requirements
# 3. Clear PageCache, dentries and inodes
# 2. Clear dentries and inodes.
# 1. Clear PageCache only.
FlushLvl="3"

xsn=" sync; "
xec=" echo "
tdate=$(date)
vms=" vmstat"
vmo=" -a -m -w -n "
vmg="| grep cache"

### - Use when appending features & debugging 
#$xec "status: string setups done." 

fx_runstat () {
    $xec "status: ${1} done."
}

log_header () {
    $xec "=== $tdate ===" >> $runlog
}

log_vmstats () {      #Dump vmstat d ata to log
    $vms $vmo >> $runlog
    free -g >> $runlog
    #fx_runstat "log_vmstats"
}

fxclearCache () {            #Clear cache
    $scn$xec$FlushLvl > $dropcaches
    #fx_runstat "fxclearCache"
}

fxbounceSwap () {            #Clear Swap - Caution see Readme.md
  swapoff -a && swapon -a
  #fx_runstat "fxbounceSwap"
}

log_end () {
  echo "---Cache cleared" >> $runlog
}

exec_main () {
    log_header
    fxclearCache
    fxbounceSwap
    log_vmstats
    log_end
    #fx_runstat "exec_main"
}

exec_main