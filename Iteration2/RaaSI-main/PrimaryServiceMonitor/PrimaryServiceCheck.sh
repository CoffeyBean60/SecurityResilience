#!/bin/bash

echo "Script for checking the health of the primary service"

server_ip=$1
server_user=$2
serviceName=$3


while :
do
	echo "Checking health of $serviceName"
	serviceStatus=$(ssh "$server_user"@"$server_ip" "systemctl status $serviceName | grep -q 'running' && echo $?")
	if [ -z "$serviceStatus" ]; then
		echo "$serviceName has died"
		break;
	else
		echo "$serviceName is running";
	fi
	sleep 20
done

while :
do
        echo "Checking health of $serviceName"
        serviceStatus=$(ssh "$server_user"@"$server_ip" "systemctl status $serviceName | grep -q 'dead' && echo $?")
        if [ -z "$serviceStatus" ]; then
                echo "$serviceName is running"
                break;
        else
                echo "$serviceName is dead";
        fi
        sleep 20
done
