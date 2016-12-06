#!/bin/bash
echo "Mem:  $(free -m | awk 'NR==2 {print $3}') MB"
