 sudo useradd -g audio shairport
 sudo cp scripts/debian/init.d/shairport /etc/init.d/
 sudo chmod +x /etc/init.d/shairport
 sudo update-rc.d shairport defaults
