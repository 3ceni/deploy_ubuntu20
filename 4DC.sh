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
 
 apt -y update
 echo "deb http://us.archive.ubuntu.com/ubuntu/ bionic universe" >> '/etc/apt/sources.list'
 echo "deb http://us.archive.ubuntu.com/ubuntu/ bionic-updates universe" >> '/etc/apt/sources.list'
  
 hostnamectl set-hostname $magdc
 apt update
 apt -y install realmd libnss-sss libpam-sss sssd sssd-tools adcli samba-common-bin oddjob oddjob-mkhomedir packagekit
 sudo realm join -U $DCadmin FIXMT.LOCAL
 
 cp "/media/support/WP_Linux/cod/file/mkhomedir" "/usr/share/pam-configs/mkhomedir"
 chmod 644 /usr/share/pam-configs/mkhomedir
# echo "Name: activate mkhomedir" >  '/usr/share/pam-configs/mkhomedir'
# echo "Default: yes" >>  '/usr/share/pam-configs/mkhomedir'
# echo "Priority: 900" >>  '/usr/share/pam-configs/mkhomedir'
# echo "Session-Type: Additional" >>  '/usr/share/pam-configs/mkhomedir'
# echo "Session:" >>  '/usr/share/pam-configs/mkhomedir'
# echo "/trequired/t/t/tpam_mkhomedir.so umask=0022 skel=/etc/skel" >>  '/usr/share/pam-configs/mkhomedir'
 pam-auth-update
 realm permit $maglogin 
 realm permit -g "Пользователи домена"
 usermod -a -G lpadmin $maglogin
 echo "Done!!!"
 rm -f /home/rootmt/setting.txt
 rm -f /home/rootmt/4DC.sh
 shutdown -r now
fi
