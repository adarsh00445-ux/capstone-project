#!/bin/bash
threshold=85
Disk_usage=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')

Ram=$(free -m)

total=$(echo "$Ram" | awk 'NR==2 {print $2} ')
used=$(echo "$Ram" | awk 'NR==2 {print $3} ')

calculation=$(( $used * 100 / total ))

if [ "$Disk_usage" -gt "$threshold" ]
then
    echo "High usage"
    echo "$(date) High Storage" >> Storage.log
else
    echo "Normal usage"
fi

echo "..........."

if [ "$calculation" -gt "$threshold" ]
then
    echo "High"
else
    echo "Normal"
fi

echo "..........."

ps aux | sort -rn -k 4 | awk 'NR<=5 {print $2, $4, $11}'
