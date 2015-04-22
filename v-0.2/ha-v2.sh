#!/bin/bash

today=`date +%Y-%m-%d-%H-%M`
node1=$1
node2=$2
iptable1=$3
iptable2=$4


function update_routing_table {
 iptables -t mangle -F
 iptables-restore < $3

 ip route delete default via $2 dev eth0 table 1
 ip route add default via $1 dev eth0 table 1

 echo $4 >> check.log
 ip route flush cache
}


ping -c 1 $node1
if [ $? -eq 0 ]; then
 ip route show table 1 | grep $node2
 if [ $? -eq 0 ]; then
 echo 'Changing route back'
 update_routing_table $node1 $node2 $iptable1 "$today - route changed to $node1"
 fi
else
 ip route show table 1 | grep $node2
 if [ $? -ne 0 ]; then
 echo 'Changing route to $node2'
 update_routing_table $node2 $node1 $iptable2 "$today - route changed back to $node2"
 fi
fi

#END


