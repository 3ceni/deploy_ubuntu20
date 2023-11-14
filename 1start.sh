#!/bin/bash

if [[ $EUID -ne 0 ]]; then
 echo "This script must be run as root" 
 exit 1
else
 magname=''
 magnameerr='mag000'
 magpass=''
 DCadmin=''
 DCadminerr='NULLadmin'
 magdc=''
 maglogin=''
 tempstr=''
 gittoken=''
 installupdate=''
 installsoft=''
 installdc=''
 installmuzlab=''
 magname=$(ex -s +1p +q setting.txt)
 magpass=$(ex -s +2p +q setting.txt)
 DCadmin=$(ex -s +3p +q setting.txt)
 magdc=$(ex -s +4p +q setting.txt)
 maglogin=$(ex -s +5p +q setting.txt)
 gittoken=$(ex -s +6p +q setting.txt)
 installupdate=$(ex -s +7p +q setting.txt)
 installsoft=$(ex -s +8p +q setting.txt)
 installdc=$(ex -s +9p +q setting.txt)
 installmuzlab=$(ex -s +10p +q setting.txt)
 
 if [ "$magname" == "$magnameerr" ]; then
   echo "Please, change magname setting.txt"
   exit 1
 fi
 
 if [ $DCadmin == $DCadminerr ]; then
   echo "Please, change DCAdmin setting.txt" 
   exit 1
 fi
 echo "Setting load" >> ~/report.txt
 
 #set password root
 echo -e "690f326c\n690f326c\n" | passwd root
 echo "Password root update" >> ~/report.txt
 #install ssh
 echo "Install SSH"
 apt install ssh -y
 #setting ssh
 sed -i 's/#Port 22/Port 61321/' /etc/ssh/sshd_config
 sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
 sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/' /etc/ssh/sshd_config
 service ssh restart
 systemctl enable ssh
 echo "ssh installed" >> ~/report.txt

 echo "Install AnyDesk"
 #install anyDesk
 sudo wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
 echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list
 sudo apt update
 sudo apt install anydesk -y
 echo "AnyDesk installed" >> ~/report.txt
 
 #install fonts (user participation required)
 apt-get install ttf-mscorefonts-installer -y
 echo "fonts installed" >> ~/report.txt
 
 if ["$installupdate" == "0"]; then
   echo "Update/Upgrade not need" 
   exit 1
 else
   echo "Update Ubuntu"
   apt update -y 
   apt upgrade -y
   echo "update/upgrade installed" >> ~/report.txt
 fi
 
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
 echo "net folders installed" >> ~/report.txt
  
 if ["$installmuzlab" == "0"]; then
    echo "Muzlab not need" 
    exit 1
 else
   echo -e "690f326c\n" | su root
   cd ~
   wget -O - https://ftp.muzlab.ru/install.sh | bash
   apt remove pulseaudio -y
   echo "muzlab installed" >> ~/report.txt
 fi

 echo "Done!!!"
fi
