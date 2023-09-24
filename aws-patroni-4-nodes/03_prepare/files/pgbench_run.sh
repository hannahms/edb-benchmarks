#!/bin/bash -eux

let counter=1
echo "0 start" >> /tmp/pgbench-tps.txt

while true; do
  tps=$(/usr/pgsql-15/bin/pgbench -T 1400 -c 5 -h ${PGBENCH_HOST} -p 5432 -U postgres pgbench | grep "tps = ")
  echo "${counter} ${tps}" >> /tmp/pgbench-tps.txt
  let counter++
  sleep 2
done
