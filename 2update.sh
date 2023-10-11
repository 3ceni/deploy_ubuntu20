#!/bin/bash

if [[ $EUID -ne 0 ]]; then
 echo "This script must be run as root" 
 exit 1
else
 magname=''
 magpass=''
 DCadmin=''
 magdc=''
 maglogin=''
 tempstr=''
 magname=$(ex -s +1p +q setting.txt)
 magpass=$(ex -s +2p +q setting.txt)
 DCadmin=$(ex -s +3p +q setting.txt)
 magdc=$(ex -s +4p +q setting.txt)
 maglogin=$(ex -s +5p +q setting.txt)
 #update Ubuntu
 echo "Update Ubuntu"
 apt update -y 
 apt upgrade -y
 #set hostname
 hostnamectl set-hostname $magname
 #install soft
 apt-get install -y cifs-utils
 sudo mkdir /media/shops
 sudo chmod 777 /media/shops
 sudo mkdir /media/videoforto
 sudo chmod 777 /media/videoforto
 sudo mkdir /media/support
 sudo chmod 777 /media/support
 #set fstab
 echo "//10.8.29.4/shops /media/shops cifs user,username="$maglogin",password="$magpass",iocharset=utf8,file_mode=0777,dir_mode=0777  0 0" >> '/etc/fstab'
 echo "//10.8.29.4/videoforto /media/videoforto cifs user,username="$maglogin",password="$magpass",iocharset=utf8,file_mode=0777,dir_mode=0777  0 0" >> /etc/fstab
 echo "//10.6.6.119/Distrib/Linux /media/support cifs user,username=support,password=zsedcX2019$,iocharset=utf8,file_mode=0777,dir_mode=0777  0 0" >> /etc/fstab
 echo -e "690f326c\n" | su root
 cd ~
 wget -O - https://ftp.muzlab.ru/install.sh | bash
 apt remove pulseaudio -y
 rm -f /home/rootmt/2update.sh
 shutdown -r now
echo "Done!!!"
fi
