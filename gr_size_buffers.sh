#!/bin/bash

sysctl -w net.core.rmem_max=50000000
sysctl -w net.core.wmem_max=1048576

#Remember, I need root privileges, yo
