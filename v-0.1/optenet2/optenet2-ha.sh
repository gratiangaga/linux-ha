#!/bin/bash

today=`date +%Y-%m-%d-%H-%M`
ipsquid1=172.31.14.117
ipsquid2=172.31.10.23


ping -c 1 $ipsquid2
if [ $? -ne 0 ]; then
 ip route show table 1 |grep $ipsquid1
  if [ $? -ne 0 ]; then
   echo 'Changing route to rproxy1'

   iptables -t mangle -F
   iptables-restore <iptables.rproxy2

   ip route delete default via $ipsquid2 dev eth0 table 1
   ip route add default via $ipsquid1 dev eth0 table 1

   echo "$today: Changing route to rproxy1. Incident is recorded in log file (check.log)"
   echo $today - route chenged to rproxy1 >>check.log
   ip route flush cache

  fi
fi

function check_ping() {
 ret=0
 ping -c 1 $ipsquid1
 ret=$(( $ret + $? ))
 ping -c 1 $ipsquid2
 ret=$(( $ret + $?))

 return $ret
}

check_ping
if [ $? -eq 0 ]; then
 ip route show talbe 1 |grep $ipsquid1
  if [ $? -eq 0 ]; then

   echo 'Changing route back'
   iptables -t mangle -F
   iptables-restore <iptables.rproxy2

   ip route delete default via $ipsquid1 dev eth0 table 1
   ip route add default via $ipsquid2 dev eth0 table 1

   echo "$today: Changing route back to rproxy2. Incident is recorded in log file (check.log)"
   echo $today - route chenged back to rproxy2 >>check.log

   ip route flush cache

  fi
fi

#END

