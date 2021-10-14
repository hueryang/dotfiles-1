#!/bin/bash

freq=${1:-performance}
for c in $(ls -d /sys/devices/system/cpu/cpu[0-9]*); do echo $freq > ${c}/cpufreq/scaling_governor; done
