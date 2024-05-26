#!/bin/sh

iptables -t nat -F
iptables -t nat -Z

iptables -t nat -A PREROUTING -i eth2 -d 100.209.1.100 -p tcp --dport 80 -j DNAT --to-destination 10.209.2.30:80

# Parte 2.2.2
iptables -t nat -A PREROUTING -i eth2 -d 100.209.1.100 -p udp --dport 5001 -j DNAT --to-destination 10.209.0.10:5001
iptables -t nat -A PREROUTING -i eth2 -d 100.209.1.100 -p udp --dport 5002 -j DNAT --to-destination 10.209.0.20:5001