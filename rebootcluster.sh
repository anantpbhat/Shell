#!/bin/bash

UP=0
UPH=""
DNH=""

checkactive () {
	for N in A B C D E F G H
		do
		ssh $N "uptime" && {
			UP=$(expr $UP + 1);
			UPH=$(echo "$N $UPH");
		} || DNH=$(echo "$DNH $N")
	done
}

checkactive;

for B in $DNH
do
	echo "Starting Down Servers"
	sleep 2
	UP=$(expr $UP + 1)
done

sleep 10

for N in $UPH
do
	[ $UP -gt 5 ] && {
		echo "$N Rebooting Now...";
		ssh $N "/sbin/shutdown -g 0 -i 6";
		sleep 3;
		UP=$(expr $UP - 1);
	} || {
		echo "Out of Quorum";
		exit 1;
	}
done
