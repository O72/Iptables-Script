#!/bin/bash

ip=iptables

$ip -A INPUT -p tcp --dport 22 -j DROP 

$ip -A INPUT -p tcp --dport 80 -j ACCEPT
$ip -A OUTPUT -p tcp -m state --state=ESTAB,REL -j ACCEPT
$ip -A OUTPUT -p tcp --dport 3306 -d 10.0.0.1 -j ACCEPT
$ip -A INPUT -p tcp --sport 3306 -s 10.0.0.1 -j ACCEPT
# Default drop
$ip -A INPUT -j DROP
$ip -A OUTPUT -j DROP
sleep 5 && $ip -F 
