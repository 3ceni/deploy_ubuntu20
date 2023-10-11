#!/bin/bash

if [[ $EUID -ne 0 ]]; then
 echo "This script must be run as root" 
 exit 1
else 
 #install soft
 apt-get install mc net-tools gnome-tweak-tool htop curl -y
 #install fonts (need apply license)
 apt-get install ttf-mscorefonts-installer -y
 wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
 sudo dpkg -i --force-depends google-chrome-stable_current_amd64.deb
 sudo add-apt-repository ppa:atareao/flameshot -y
 sudo apt update
 sudo apt install flameshot -y
 #install language-pack
 sudo apt-get update
 sudo apt-get install language-pack-ru -y
 sudo apt-get install language-pack-gnome-ru -y
 sudo apt-get install libreoffice-l10n-ru -y
 sudo apt-get install hyphen-ru mythes-ru hunspell-ru -y
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
 #extract archiv
 tar xvzf 3010-linux-UFRII-drv-v550-us-00.tar.gz
 cd linux-UFRII-drv-v550-us
 echo -e "y\n" | sudo ./install.sh
 cd ..
 #install scanner
 apt-get install xsane libusb-dev git -y
 #disable USB-port
 cd /lib/modules/`uname -r`/kernel/drivers/usb/storage/
 sudo mv usb-storage.ko usb-storage.ko.blacklist
 cd /home/rootmt
 #install VLC
 apt-get install vlc -y
 #remove games
 apt remove gnome-mahjongg -y
 apt remove gnome-mines -y
 apt remove gnome-sudoku -y
 apt remove aisleriot -y
 #install winrar (snap)
 snap install winrar
 #install WPS-Office
 snap install wps-office-multilang
 #install viber
 apt install fuse binutils -y
 rm -f /home/rootmt/3install.sh
 shutdown -r now   
echo "Done!!!"
fi
