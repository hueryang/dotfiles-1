#!/usr/bin/env bash
for file in `find /tmp -maxdepth 1 -user $USER  -name "polybar*"`
do 
  echo "cmd:toggle" | tee $file > /dev/null
done

