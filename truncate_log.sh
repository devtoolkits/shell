#!/bin/sh
SIZE="+1G"
DAYS="+3"
LOGFILE="/path/to/truncate.log"
[ -d $(dirname ${LOGFILE}) ] || mkdir -p $(dirname ${LOGFILE})

date >> ${LOGFILE}
find /path/to/find \
    -xdev \
    -mtime ${DAYS} \
    -iname '*.log*' \
    -type f \
    -size ${SIZE} \
    -print0 | xargs -0 -I{} file -0 --mime-type {} | awk 'BEGIN {FS="\000"} $NF ~ "text/plain" {print $1}' | tee -a $LOGFILE | xargs -I{} truncate -s 0 {}
