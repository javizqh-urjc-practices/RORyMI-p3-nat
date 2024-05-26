#!/bin/sh

# Parte 2.1
iptables -t nat -F
iptables -t nat -Z

iptables -t nat -A POSTROUTING -s 10.209.0.0/16 -o eth2 -j SNAT --to-source 100.209.1.100

# Parte 3
iptables -t filter -F
iptables -t filter -Z

iptables -t filter -P INPUT DROP
iptables -t filter -P FORWARD DROP
iptables -t filter -P OUTPUT ACCEPT

iptables -t filter -A INPUT -i eth0 -j ACCEPT

iptables -t filter -A FORWARD -i eth0 -o eth2 -j ACCEPT
iptables -t filter -A FORWARD -i eth2 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT

iptables -t filter -A FORWARD -i eth2 -o eth1 -d 100.209.0.40 -p udp --dport 7 -j LOG --log-prefix echo
iptables -t filter -A FORWARD -i eth2 -o eth1 -d 100.209.0.40 -p udp --dport 7 -j ACCEPT

iptables -t filter -A FORWARD -i eth2 -o eth1 -d 100.209.0.50 -p udp --dport 13 -j LOG --log-prefix daytime
iptables -t filter -A FORWARD -i eth2 -o eth1 -d 100.209.0.50 -p udp --dport 13 -j ACCEPT

iptables -t filter -A FORWARD -i eth0 -o eth1 -d 100.209.0.40 -p tcp --dport 7 -j LOG --log-prefix tcp
iptables -t filter -A FORWARD -i eth0 -o eth1 -d 100.209.0.40 -p tcp --dport 7 -j ACCEPT

iptables -t filter -A FORWARD -i eth1 -o eth0 -m state --state NEW -j DROP
iptables -t filter -A INPUT -i eth1 -m state --state NEW -j DROP