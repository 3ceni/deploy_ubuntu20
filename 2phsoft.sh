#!/bin/bash

if [[ $EUID -ne 0 ]]; then
 echo "This script must be run as root" 
 exit 1
else 
 echo "*********** start install soft*****************" >> /home/rootmt/report.txt
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
 mkdir /home/rootmt/phfiles
 cp "/media/support/WP_Linux/11/MuzLab/Установка на ubuntu.docx" "/home/rootmt/phfiles/Установка на ubuntu.docx"
 cp "/media/support/WP_Linux/7-canon/3010-linux-UFRII-drv-v550-us-00.tar.gz" "/home/rootmt/phfiles/3010-linux-UFRII-drv-v550-us-00.tar.gz"
 cp "/media/support/WP_Linux/Viber/viber.AppImage" "/home/rootmt/phfiles/viber.AppImage"
 cp "/media/support/WP_Linux/Viber/Viber.desktop" "/home/rootmt/phfiles/Viber.desktop"
 cp "/media/support/WP_Linux/1С_Плэй_Хард.rdp" "/home/rootmt/phfiles/1С_Плэй_Хард.rdp"
 cp "/media/support/WP_Linux/Инструкция по работе (rev2).docx" "/home/rootmt/phfiles/Инструкция по работе (rev2).docx"
 chown -R rootmt:rootmt /home/rootmt/phfiles
 echo "phfiles coped" >> /home/rootmt/report.txt
 #extract archiv
 cd /home/rootmt/phfiles
 tar xvzf /home/rootmt/phfiles/3010-linux-UFRII-drv-v550-us-00.tar.gz
 cd /home/rootmt/phfiles/linux-UFRII-drv-v550-us
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
 #set Volume alsamixer
 amixer -c 0 set Master 100%
 amixer -c 0 set Headphone 100%
 amixer -c 0 set PCM 100%
 amixer -c 0 set Front 100%
 amixer -c 0 set Surround 100%
 amixer -c 0 set Center 100%
 amixer -c 0 set LFE 100%
 amixer -c 0 set Line 100%
 amixer -c 0 set "Line boost" 100%
 echo "Set alsamixer complite" >> /home/rootmt/report.txt
 #install winrar (snap)
 snap install winrar
 echo "winrar installed" >> /home/rootmt/report.txt
 #install WPS-Office
 snap install wps-office-multilang
 echo "WPS-Office installed" >> /home/rootmt/report.txt
 #install viber
 apt install fuse binutils -y
 echo "Viber installed" >> /home/rootmt/report.txt
 # copy code muzlab
 magname=$(ex -s +15p +q setting.txt)
 cat /home/mopidy/.muzlab_device_binding_code > /media/support/ALL_mag/$magname
 echo "Muzlab code copied" >> /home/rootmt/report.txt
 #delete file autorun
 systemctl disable rc-local
 rm -f /etc/rc.local
 mv "/home/rootmt/deploy_ubuntu20/2phsoft.sh" "/home/rootmt/deploy_ubuntu20/done/2phsoft.sh"
 
 echo "*********** Done! install soft*****************" >> /home/rootmt/report.txt
 echo "Done!!!"
 shutdown -r now
fi
