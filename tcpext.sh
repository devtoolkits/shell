#!/bin/bash

echo "["
{ cat /proc/net/netstat  | 
grep -i '^tcpext' | 
awk '{
  ts=strftime("%s");
  for(i=2;i<=NF;i++)
    NR==1?key[i]=$i:value[i]=$i
  } 
  END {
    for(i=2;i<=NF;i++)
    printf("{\"name\":\"%s\",\"value\":%d,\"timestamp\":%s},",key[i],value[i],ts)
}' |
sed 's/,$//'; } 2> /tmp/get_tcpext_info_error.log
echo "]"
