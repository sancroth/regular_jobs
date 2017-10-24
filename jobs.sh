#!/bin/bash
#ps -au | grep ‘^siemons+.*pts’ | awk ‘{print $7}’ | sed ‘s/pts\///’ | sort | uniq | cat -n | awk ‘{print $2}’

count=$(ps -au | grep ‘^siemons+.*pts’ | awk ‘{print $7}’ | sed ‘s/pts\///’ | sort | uniq | wc -l)
terminals=1
while [ $terminals -le $count ]
do

toEcho=$(ps -au | grep ‘^siemons+.*pts’ | awk ‘{print $7}’ | sed ‘s/pts\///’ | sort | uniq | cat -n | grep $terminals | awk ‘{print $2}‘)

echo “” >/dev/pts/$toEcho
date >/dev/pts/$toEcho
echo “” >/dev/pts/$toEcho

echo “” >/dev/pts/$toEcho
echo “Active Agents:” >/dev/pts/$toEcho
echo “” >/dev/pts/$toEcho
/var/ossec/bin/agent_control -lc | grep ID: | cat -n >/dev/pts/$toEcho

echo “” >/dev/pts/$toEcho
echo “Disconnected Agents:” >/dev/pts/$toEcho
echo “” >/dev/pts/$toEcho
/var/ossec/bin/agent_control -l | grep Dis | cat -n >/dev/pts/$toEcho

echo “” >/dev/pts/$toEcho
echo “Reachable Critical Machines:” >/dev/pts/$toEcho
echo “” >/dev/pts/$toEcho
echo 1 5 8 30 63 100 111 200 222 230 243 244 248 249 | xargs -P255 -I% -d” ” ping -W 1 -c 1 192.168.1.% | grep -E “[0-1].*?:” | sort -g | cat -n >/dev/pts/$toEcho

echo “” >/dev/pts/$toEcho
terminals=$((terminals+1))

done
