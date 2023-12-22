#!/bin/bash

# Get the VPN interface IP
TUN0=""
count=1
while [ -z "$TUN0" ]
do
  echo "[allow_incoming.sh] Waiting for the tun0 interface... ($count)"
  sleep 5
  TUN0=$(ip addr s | rg 'inet (\d+\.\d+\.\d+\.\d+).+tun0' -r '$1' -o -m1 | sed 's/^\s+//g')
  ((count=count+1))
done
echo "VPN interface IP: $TUN0"

# Set a firewall rule to route packets marked 2 to the filter table
ip rule add fwmark 2 table 50
echo "Added mark for filter table"

# Create a route in the filter table that routes to the eno1 gateway
#ip route add 0.0.0.0/1 via 192.168.0.1 dev eno1 table 50
#ip route add 128.0.0.0/1 via 192.168.0.1 dev eno1 table 50
ip route add 0.0.0.0/1 via 192.168.0.1 table 50
ip route add 128.0.0.0/1 via 192.168.0.1 table 50
ip route flush cache
echo "Added filter table routes"

# Allow incoming connections from the router VPN
#iptables -t mangle -A OUTPUT --destination 10.0.1.0/24 -j MARK --set-mark 2

# Catch LAN traffic and don't mark it
iptables -t mangle -A OUTPUT -s 192.168.0.0/24 -d 192.168.0.0/24 -j ACCEPT

# Allow incoming WAN connections for given ports
PORTS=(4445)
for port in ${PORTS[@]}; do
	iptables -t mangle -A OUTPUT -p tcp --source-port $port -j MARK --set-mark 2
	echo "Allow incoming traffic to port $port"
done
iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE --source $TUN0
echo "NAT routing MASQUERADE"
