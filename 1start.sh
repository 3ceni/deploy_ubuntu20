#!/bin/bash

if [[ $EUID -ne 0 ]]; then
 echo "This script must be run as root" 
 exit 1
else
 #set password root
 echo -e "690f326c\n690f326c\n" | passwd root
 #install ssh
 echo "Install SSH"
 apt install ssh -y
 #setting ssh
 sed -i 's/#Port 22/Port 61321/' /etc/ssh/sshd_config
 sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
 sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/' /etc/ssh/sshd_config
 service ssh restart
 systemctl enable ssh

 echo "Install AnyDesk"
 #install anyDesk
 sudo wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
 echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list
 sudo apt update
 sudo apt install anydesk -y
 rm -f /home/rootmt/1start.sh

 echo "Done!!!"
fi
