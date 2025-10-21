#!/bin/sh 

status=$(sudo wg show)
if [ -z "$status" ]; then
	echo "{\"text\": \"󰒃\", \"class\": \"vpn-inactive\"}"
	exit 0
fi

echo "{\"text\": \"󰒃\", \"class\": \"vpn-active\"}"
exit 0
