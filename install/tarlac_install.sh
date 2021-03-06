#!/bin/sh

# These are for all configurations
PROGRAMS_TO_INSTALL='openssh-server wget'
PROGRAMS_TO_REMOVE="gnome-games gnome-games-data openoffice.org-common f-spot ekiga evolution pidgin totem totem-common brasero rhythmbox synaptic gimp"

# Call "install wget" to add wget to the list of programs to install
install() {
  PROGRAMS_TO_INSTALL="${PROGRAMS_TO_INSTALL} ${1}"
}

remove() {
  PROGRAMS_TO_REMOVE="${PROGRAMS_TO_INSTALL} ${1}"
}

client () {
  echo "Client"
  install "tuxtype"
  apt-get --assume-yes install $PROGRAMS_TO_INSTALL
  apt-get --assume-yes remove $PROGRAMS_TO_REMOVE
  apt-get --assume-yes upgrade

# Make firefox launch automatically and point it at http://chits_server
  AUTOSTART_DIR=$HOME/.config/autostart
  mkdir --parents $AUTOSTART_DIR
  echo "[Desktop Entry]
Type=Application
Encoding=UTF-8
Version=1.0
Name=No Name
Name[en_US]=Firefox
Comment[en_US]=Firefox
Comment=Firefox
Exec=/usr/bin/firefox -no-remote -P default http://chits_server
X-GNOME-Autostart-enabled=true" > $AUTOSTART_DIR/firefox.desktop
  echo "
# chits server should be found at 192.168.0.1  
192.168.0.1 chits_server" >> /etc/hosts
  wget http://github.com/mikeymckay/chits/raw/master/install/tarlac_firefox_profile.zip
  unzip tarlac_firefox_profile.zip
}

server () {
  echo "Server"
  apt-get --assume-yes install $PROGRAMS_TO_INSTALL
  apt-get --assume-yes remove $PROGRAMS_TO_REMOVE
  apt-get --assume-yes upgrade
  wget http://github.com/mikeymckay/chits/raw/master/install/chits_install.sh
  chmod +x chits_install.sh
  ./chits_install.sh
  echo "
# chits server should be found here
127.0.0.1 chits_server" >> /etc/hosts
# TODO set ip
# setup dhcp
# setup dns
}

client_and_server () {
  echo "Client & Server"
  server
  client
}

access_point () {
  echo "Access point"
#TODO!!

}

server_and_access_point () {
  server
  access_point
}

client_and_server_and_access_point () {
  server
  client
  access_point
}

#TODO!!
client_with_mysql_replication () {
  install "mysql-server"
  client
}

while : # Loop forever
do
cat << !

${PROGRAMS_TO_INSTALL}

Install Script for Tarlac

1. Client
2. Server
3. Client & Server
4. Server & Access Point
5. Client & Server & Access Point
6. Client with mysql replication
7. Exit

!

echo -n " Your choice? : "
read choice

case $choice in
1) client; exit ;;
2) server; exit ;;
3) client_and_server; exit ;;
4) server_and_access_point; exit ;;
5) client_and_server_and_access_point ; exit ;;
6) client_with_mysql_replication; exit ;;
7) exit ;;
*) echo "\"$choice\" is not valid "; sleep 2 ;;
esac
done

exit
