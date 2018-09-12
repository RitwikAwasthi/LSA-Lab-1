#!/bin/bash

CPULOADAVG="$(uptime | grep -ohe 'load average[s:][: ].*' | sed 's/load average: //')"
FREEMEM="$(free -m | awk '{print $4}' | sed -n '2 p')"
TOTALUSERS="$(cat /etc/passwd | wc | awk '{print $1}')"
ACTIVEUSERS="$(who | wc -l)"
NOLOGIN="$(grep -c "/sbin/nologin/*" /etc/passwd)"
BASH="$(grep -c "/bin/bash/*" /etc/passwd)"
FALSE="$(grep -c "/bin/false/*" /etc/passwd)"
TOTALFILES="$(find / | wc -l)"
TOTALDIR="$(find / -type d | wc -l)"
IOBYTESIN="$(cat /proc/net/dev | awk '{print $2}' | sed -n '3 p')"
IOBYTESOUT="$(cat /proc/net/dev | awk '{print $10}' | sed -n '3 p')"
ENPBYTESIN="$(cat /proc/net/dev | awk '{print $2}' | sed -n '4 p')"
ENPBYTESOUT="$(cat /proc/net/dev | awk '{print $10}' | sed -n '4 p')"
TOPCOUNT="$(cat /etc/passwd | cut -d ":" -f7 | sort | uniq -c | sort -n -r | sed -n '1 p' | awk '{print $1}')"
SECCOUNT="$(cat /etc/passwd | cut -d ":" -f7 | sort | uniq -c | sort -n -r | sed -n '2 p' | awk '{print $1}')"
THRCOUNT="$(cat /etc/passwd | cut -d ":" -f7 | sort | uniq -c | sort -n -r | sed -n '3 p' | awk '{print $1}')"
TOP="$(cat /etc/passwd | cut -d ":" -f7 | sort | uniq -c | sort -n -r | sed -n '1 p' | awk '{print $2}')"
SEC="$(cat /etc/passwd | cut -d ":" -f7 | sort | uniq -c | sort -n -r | sed -n '2 p' | awk '{print $2}')"
THR="$(cat /etc/passwd | cut -d ":" -f7 | sort | uniq -c | sort -n -r | sed -n '3 p' | awk '{print $2}')"




if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
	CONNECTION="YES"
else
	CONNECTION="NO"
fi

echo "CPU AND MEMORY RESOURCES -----------------------------"
printf "\n"
printf "CPU Load Average: %s   Free Memory: %sMB\n" "$CPULOADAVG" "$FREEMEM"
printf "\n"
echo "NETWORK CONNECTIONS ----------------------------------"
printf "\n"
printf "IO BYTES RECIVED: %s    BYTES TRANSMITTED: %s \n" "$IOBYTESIN" "$IOBYTESOUT"
printf "enp0s3 BYTES RECIVED: %s   BYTES TRANSMITTED: %s \n" "$ENPBYTESIN" "$ENPBYTESOUT"
printf "INTERNET CONNECTIVITY: %s \n" "$CONNECTION"
printf "\n"
echo "ACCOUNT INFORMATION ----------------------------------"
printf "\n"
printf "TOTAL USERS: %s   ACTIVE USERS: %s \n" "$TOTALUSERS" "$ACTIVEUSERS"
printf "SHELLS: \n"
printf "%s: %s \n" "$TOP" "$TOPCOUNT"
printf "%s: %s \n" "$SEC" "$SECCOUNT"
printf "%s: %s \n" "$THR" "$THRCOUNT"
printf "\n" 

echo "FILESYSTEM INFORMATION -------------------------------"
printf "\n"
printf "TOTAL NUMBER OF FILES: %s \n" "$TOTALFILES"
printf "TOTAL NUMBER OF DIRECTORIES: %s \n" "$TOTALDIR"
printf "\n"
echo "------------------------------------------------------"
