#!/bin/bash

today=`date +%Y-%m-%d-%H-%M`
ipopt1=172.31.8.250
ipopt2=172.31.0.8


ping -c 1 $ipopt1
if [ $? -ne 0 ]; then
 ip route show table 1 |grep $ipopt2
  if [ $? -ne 0 ]; then
   echo 'Changing route to ropt2'

   iptables -t mangle -F
   iptables-restore <iptables.uvpn2

   ip route delete default via $ipopt1 dev eth0 table 1
   ip route add default via $ipopt2 dev eth0 table 1

   echo "$today: Changing route to ropt2. Incident is recorded in log file (check.log)"
   echo $today - route chenged to ropt2 >>check.log
   ip route flush cache

  fi
fi

function check_ping() {
 ret=0
 ping -c 1 $ipopt1
 ret=$(( $ret + $? ))
 ping -c 1 $ipopt2
 ret=$(( $ret + $?))

 return $ret
}

check_ping
if [ $? -eq 0 ]; then
 ip route show table 1 |grep $ipopt2
 if [ $? -eq 0 ]; then

  echo 'Changing route back'
  iptables -t mangle -F
  iptables-restore <iptables.uvpn1

  ip route delete default via $ipopt2 dev eth0 table 1
  ip route add default via $ipopt1 dev eth0 table 1

  echo "$today: Changing route back to ropt1. Incident is recorded in log file (check.log)"
  echo $today - route chenged back to ropt1 >>check.log

  ip route flush cache
 fi
fi

#END

