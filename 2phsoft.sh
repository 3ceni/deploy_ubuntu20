#!/bin/bash

if [[ $EUID -ne 0 ]]; then
 echo "This script must be run as root" 
 exit 1
else 
 echo "*********** start install soft*****************" >> /home/rootmt/report.txt
 magname=''
 magnameerr='mag000'
 magpass=''
 DCadmin=''
 passdc=''
 DCadminerr='NULLadmin'
 magdc=''
 maglogin=''
 tempstr=''
 gittoken=''
 installupdate=''
 installsoft=''
 installdc=''
 installmuzlab=''
 magname=$(ex -s +16p +q setting.txt)
 magpass=$(ex -s +17p +q setting.txt)
 DCadmin=$(ex -s +18p +q setting.txt)
 passdc=$(ex -s +19p +q setting.txt)
 magdc=$(ex -s +20p +q setting.txt)
 maglogin=$(ex -s +21p +q setting.txt)
 gittoken=$(ex -s +22p +q setting.txt)
 installupdate=$(ex -s +23p +q setting.txt)
 installsoft=$(ex -s +24p +q setting.txt)
 installdc=$(ex -s +25p +q setting.txt)
 installmuzlab=$(ex -s +26p +q setting.txt)
 #install soft
 apt-get install mc net-tools gnome-tweak-tool htop curl -y
 echo "utilites installed" >> /home/rootmt/report.txt
 wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
 sudo dpkg -i --force-depends google-chrome-stable_current_amd64.deb
 sudo add-apt-repository ppa:atareao/flameshot -y
 sudo apt update
 echo "google chrome installed" >> /home/rootmt/report.txt
 sudo apt install flameshot -y
 echo "flameshot installed" >> /home/rootmt/report.txt
 #install language-pack
 sudo apt-get update
 sudo apt-get install language-pack-ru -y
 sudo apt-get install language-pack-gnome-ru -y
 sudo apt-get install libreoffice-l10n-ru -y
 sudo apt-get install hyphen-ru mythes-ru hunspell-ru -y
 echo "language-pack installed" >> /home/rootmt/report.txt
 #set locate
 sed -i 's/LANG="en_US.UTF-8"/LANG="ru_RU.UTF-8"/' /etc/default/locale
 echo "LANGUAGE=\"ru:en\"" >> '/etc/default/locale'
 #Copy files
 cp "/media/support/WP_Linux/11/MuzLab/Установка на ubuntu.docx" "/home/rootmt/Установка на ubuntu.docx"
 cp "/media/support/WP_Linux/7-canon/3010-linux-UFRII-drv-v550-us-00.tar.gz" "/home/rootmt/3010-linux-UFRII-drv-v550-us-00.tar.gz"
 cp "/media/support/WP_Linux/Viber/viber.AppImage" "/home/rootmt/viber.AppImage"
 cp "/media/support/WP_Linux/Viber/Viber.desktop" "/home/rootmt/Viber.desktop"
 cp "/media/support/WP_Linux/1С_Плэй_Хард.rdp" "/home/rootmt/1С_Плэй_Хард.rdp"
 cp "/media/support/WP_Linux/Инструкция по работе (rev2).docx" "/home/rootmt/Инструкция по работе (rev2).docx"
 echo "phfiles coped" >> /home/rootmt/report.txt
 #extract archiv
 tar xvzf 3010-linux-UFRII-drv-v550-us-00.tar.gz
 cd linux-UFRII-drv-v550-us
 echo -e "y\n" | sudo ./install.sh
 echo "driver MF3010 installed" >> /home/rootmt/report.txt
 cd ..
 #install scanner
 apt-get install xsane libusb-dev git -y
 echo "drivers scaner installed" >> /home/rootmt/report.txt
 #disable USB-port
 cd /lib/modules/`uname -r`/kernel/drivers/usb/storage/
 sudo mv usb-storage.ko usb-storage.ko.blacklist
 echo "USB-ports disable" >> /home/rootmt/report.txt
 cd /home/rootmt
 #install VLC
 apt-get install vlc -y
 echo "VLC installed" >> /home/rootmt/report.txt
 #remove games
 apt remove gnome-mahjongg -y
 apt remove gnome-mines -y
 apt remove gnome-sudoku -y
 apt remove aisleriot -y
 echo "games removed" >> /home/rootmt/report.txt
 #install winrar (snap)
 snap install winrar
 echo "winrar installed" >> /home/rootmt/report.txt
 #install WPS-Office
 snap install wps-office-multilang
 echo "WPS-Office installed" >> /home/rootmt/report.txt
 #install viber
 apt install fuse binutils -y
 echo "Viber installed" >> /home/rootmt/report.txt
 
 if [ $installdc == 0 ]; then
   echo "connect to DC not need" >> /home/rootmt/report.txt 
 else
   touch /etc/rc.local
   echo "#!/bin/bash" >> /etc/rc.local
   sed -i 's/2phsoft.sh/3phdc.sh/' /etc/rc.local
   echo "exit 0" >> /etc/rc.local   
   echo "connect to DC will be connected after reboot" >> /home/rootmt/report.txt
 fi
 
 echo "*********** Done! install soft*****************" >> /home/rootmt/report.txt
 echo "Done!!!"
fi
