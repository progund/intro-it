#!/bin/bash

GW=$(ip r | grep default | cut -d ' ' -f 1-5)
NETWORK_CARDS=$(ip link | grep ^[0-9] | cut -d ':' -f2 | tr '\n' ' ' )
IPS=$(for card in $NETWORK_CARDS
      do
          addr=$(ip address |
                        grep -A2 ${card}: |
                        grep 'inet ' |
                        awk '{print $2;}')
          echo -n " $card: $addr"
      done
   )
CAN_PING_SUNET=false

echo -n "Pinging ftp.sunet.se..."
ping -c 1 -w 3 ftp.sunet.se &> /dev/null && CAN_PING_SUNET=true
echo "Done!"

echo -n "Counting hops to pts.se..."
HOPS_TO_PTS=$(mtr -r -c 1 pts.se 2> /dev/null | tail -1 | cut -d '.' -f1 )
echo "Done!"
echo
echo "Network cards: $NETWORK_CARDS"
echo "IP addresses: $IPS"
echo "Default gateway: $GW"
echo "Computer hostname: $HOSTNAME" # environment variable
if $CAN_PING_SUNET
then
    echo "Ping to ftp.sunet.se successful."
else
    echo "Could not ping ftp.sunet.se. Do you have a network connection?"
fi

if [[ -z "$HOPS_TO_PTS" ]]
then
    echo "Could not count hops to pts.se . Network problem?"
else
    echo "There were $HOPS_TO_PTS hops to pts.se"
fi
