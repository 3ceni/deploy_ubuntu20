#!/bin/bash

if [[ $EUID -ne 0 ]]; then
 echo "This script must be run as root" 
 exit 1
else
 echo "Hello, world!"
 read -p "Are you done now? " answer
 case $answer in
  y) echo "Goodbye";;
  n) echo "Sorry, this is the end.";;
 esac 
fi
