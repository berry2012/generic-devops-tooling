#!/bin/bash

# this script allows you create linux users on Amazon linux 


echo "Welcome. this script allows you create linux users on Amazon linux"
read -p 'username of the new user: ' usernamevar;
read -p 'password of the new user: ' passwordvar;
echo ""
yum update -y
useradd -p $(openssl passwd -1 $passwordvar) $usernamevar
mkdir /home/$usernamevar
chmod 700 /home/$usernamevar
chown $usernamevar:$usernamevar /home/$usernamevar
usermod -s /bin/bash $usernamevar
mkdir /home/$usernamevar/.ssh
chown $usernamevar:$usernamevar /home/$usernamevar/.ssh
usermod -aG $usernamevar
echo '$usernamevar ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
echo 'User $usernamevar has been created....'


