#!/bin/bash

#----------------------------------------------------------------------------------------------#
# Setup                                                                                        #
#----------------------------------------------------------------------------------------------#
set -euo pipefail

#----------------------------------------------------------------------------------------------#
# Variables                                                                                    #
#----------------------------------------------------------------------------------------------#
hostname=$(dialog --stdout --inputbox "Enter hostname" 0 0) || exit 1
clear
#: ${hostname:?"hostname cannot be empty"}

user=$(dialog --stdout --inputbox "Enter root username" 0 0) || exit 1
clear
#: ${user:?"user cannot be empty"}

password=$(dialog --stdout --passwordbox "Enter root password" 0 0) || exit 1
clear
#: ${password:?"password cannot be empty"}
password2=$(dialog --stdout --passwordbox "Enter root password again" 0 0) || exit 1
clear
[[ "$password" == "$password2" ]] || ( echo "Passwords did not match"; exit 1; )

devicelist=$(lsblk -dplnx size -o name,size | grep -Ev "boot|rpmb|loop" | tac)
device=$(dialog --stdout --menu "Select installation disk" 0 0 0 ${devicelist}) || exit 1
clear
