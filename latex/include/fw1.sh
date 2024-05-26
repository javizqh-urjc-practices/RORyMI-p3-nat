#!/bin/sh

iptables -t nat -F
iptables -t nat -Z

iptables -t nat -A POSTROUTING -s 10.209.0.0/16 -o eth2 -j SNAT --to-source 100.209.1.100
