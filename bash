#!/bin/bash

ip=iptables

# Drop all SSH
$ip -A INPUT -p tcp --dport 22 -j DROP 
# Allow all http
$ip -A INPUT -p tcp --dport 80 -j ACCEPT
# Allow all EST,REL outbound
$ip -A OUTPUT -p tcp -m state --state=ESTAB,REL -j ACCEPT
# Allow remote MySQL from specific IP address
$ip -A OUTPUT -p tcp --dport 3306 -d 10.0.0.7 -j ACCEPT
$ip -A INPUT -p tcp --sport 3306 -s 10.0.0.7 -j ACCEPT
# Default drop
$ip -A INPUT -j DROP
$ip -A OUTPUT -j DROP
# Comment out when tested
sleep 5 && $ip -F 
