#!/bin/bash

MAILLEVEL=80
while true
do
	ROOTUSAGE="$(df /  -h | awk '{print $5}' | sed 1d | sed 's/%//')"
	BOOTUSAGE="$(df -h | grep boot | awk '{print $5}' | sed 's/%//')"

	if [ $BOOTUSAGE -gt $MAILLEVEL ] || [ $ROOTUSAGE -gt $MAILLEVEL ] ; then
		echo "Disk usage has exceeded 80% threshold and is now almost at max capacity" | mail -s 'Critical Disk Space' root@localhost
	fi
done
