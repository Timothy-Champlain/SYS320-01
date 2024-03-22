#!/bin/bash

ip="$(ip addr | grep "brd" | grep -o -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}")"

echo "$ip" | head -n 1
