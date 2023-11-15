#!/bin/bash

if [[ $EUID -ne 0 ]]; then
 echo "This script must be run as root" 
 exit 1
else
 echo "*********** start connect to dc *****************" >> /home/rootmt/report.txt
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
 magname=$(ex -s +15p +q setting.txt)
 magpass=$(ex -s +16p +q setting.txt)
 DCadmin=$(ex -s +17p +q setting.txt)
 magdc=$(ex -s +18p +q setting.txt)
 maglogin=$(ex -s +19p +q setting.txt)
 gittoken=$(ex -s +20p +q setting.txt)
 installupdate=$(ex -s +21p +q setting.txt)
 installsoft=$(ex -s +22p +q setting.txt)
 installdc=$(ex -s +23p +q setting.txt)
 installmuzlab=$(ex -s +24p +q setting.txt)
 echo "Setting load" >> /home/rootmt/report.txt
 apt -y update
 echo "deb http://us.archive.ubuntu.com/ubuntu/ bionic universe" >> '/etc/apt/sources.list'
 echo "deb http://us.archive.ubuntu.com/ubuntu/ bionic-updates universe" >> '/etc/apt/sources.list'
 echo "repo update" >> /home/rootmt/report.txt 
 hostnamectl set-hostname $magdc
 apt update
 apt -y install realmd libnss-sss libpam-sss sssd sssd-tools adcli samba-common-bin oddjob oddjob-mkhomedir packagekit
 sudo realm join -U $DCadmin FIXMT.LOCAL
 echo "connected to dc" >> /home/rootmt/report.txt
 cp "/media/support/WP_Linux/cod/file/mkhomedir" "/usr/share/pam-configs/mkhomedir" 
 chmod 644 /usr/share/pam-configs/mkhomedir
 pam-auth-update
 realm permit $maglogin 
 realm permit -g "Пользователи домена"
 echo "add user's permit" >> /home/rootmt/report.txt
 cp "/media/support/WP_Linux/userfolder/defaultuser.tgz" "/home/rootmt/phfiles/defaultuser.tgz"
 cd /home/rootmt/phfiles
 tar xvzf defaultuser.tgz
 mv /home/rootmt/phfiles/magif2@FIXMT.local /home/$magname@FIXMT.local
 sudo chown -R "$magname@FIXMT.local":"пользователи домена@FIXMT.local" /home/$magname@FIXMT.local/
 usermod -a -G lpadmin $magname@fixmt.local
 echo "Folder for user setup" >> /home/rootmt/report.txt
 sed -i '/support/d' /etc/fstab
 mv "/home/rootmt/deploy_ubuntu20/4DC.sh" "/home/rootmt/deploy_ubuntu20/done/4DC.sh"
 rm -f /home/rootmt/deploy_ubuntu20
# echo "folder git removed" >> /home/rootmt/report.txt
 echo "Done!!!"
 echo "*********** Done connect to dc *****************" >> /home/rootmt/report.txt
 shutdown -r now
fi
