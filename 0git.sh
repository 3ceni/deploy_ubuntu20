#!/bin/bash

if [[ $EUID -ne 0 ]]; then
 echo "This script must be run as root" 
 exit 1
else
 apt update
 apt install git -y
 git clone https://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@github.com/3ceni/deploy_ubuntu20.git
 echo "git installed" >> /home/rootmt/report.txt
 chown -R rootmt:rootmt /home/rootmt/deploy_ubuntu20
 chmod +x /home/rootmt/deploy_ubuntu20/*.sh
 
 echo "Done!!!"
fi
