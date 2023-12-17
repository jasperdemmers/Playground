#!/bin/bash

# Check if all arguments are provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <number>"
    exit 1
fi

number=$1

if [[ $number =~ ^0[1-9]$ ]]; then
  # If so, remove the leading zero
  number=${number#0}
fi


echo number=$number