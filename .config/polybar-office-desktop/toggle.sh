#!/usr/bin/env bash
for file in `find /tmp -maxdepth 1 -user $USER  -name "polybar*"`
do 
  echo "cmd:toggle" | tee $file > /dev/null
done

if [ `bspc config top_padding` -gt 0 ]; then
  bspc config top_padding 0
else
  bspc config top_padding 26
fi

