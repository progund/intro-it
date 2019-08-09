#!/bin/bash

GW=$(ip r | grep default | cut -d ' ' -f 1-5)
IP=$(hostname -I)

echo "Default gateway: $GW"
echo "IP number(s): $IP"
echo "Hostname: $HOSTNAME" # environment variable
