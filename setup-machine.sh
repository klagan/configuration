# add the new user
# sudo useradd -G sudo -m kam -s /bin/bash
# sudo usermod -aG adm,cdrom,sudo,dip,plugdev,lpadmin,lxd,sambashare
# sudo passwd kam

# delete the old user
# sudo userdel parallels

# set the hostname
# hostnamectl set-hostname <new hostname>

# set date time format
# timedatectl set-timezone UTC

# set the system locale
# sudo localectl set-locale LANG=en_GB.UTF-8

# set default shell to zsh (must be installed)
# chsh -s /bin/zsh

# keyboard: English (UK, Macintosh)
