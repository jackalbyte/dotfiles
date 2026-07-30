#!/bin/bash

# Check if IP address and ports are provided
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <ip_address> <port1> <port2> ... <portn>"
    exit 1
fi

# Store the IP address
ip_address=$1
echo "Knocking on $ip_address"

# Shift the arguments to start from the ports
shift

# Loop through the ports and knock
for port in "$@"; do
    echo "Knocking on port $port"
    # Knock ports are usually closed, so nc commonly returns a non-zero status
    # after sending the connection attempt. The attempt itself is the knock.
    nc -w 1 -G 1 -z "$ip_address" "$port" > /dev/null 2>&1 || true
done

echo "Port knocking sequence completed successfully on $ip_address"
