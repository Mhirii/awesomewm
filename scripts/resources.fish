#!/bin/fish

if test "$argv" = "cpu"
    set cpuUsage (top -bn1 | awk '/Cpu/ { print $2}')
    echo "$cpuUsage"
else if test "$argv" = "ram"
    set memUsage (free | awk '/Mem/ {print $4/$2 * 100}')
    echo "$memUsage"
else
    set cpuUsage (top -bn1 | awk '/Cpu/ { print $2}')
    echo "$cpuUsage"
    set memUsage (free | awk '/Mem/ {print $4/$2 * 100}')
    echo "$memUsage"
end


