#!/bin/bash

HOSTNAME = dumbass
USERNAME = dumbass
PASSWORD = dumbass

ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
sed -i '403s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo $HOSTNAME >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1	localhost" >> /etc/hosts
echo root:$PASSWORD | chpasswd

pacman -S --noconfirm grub efibootmgr networkmanager base-devel openssh os-prober man

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager

useradd -m $USERNAME
echo $USERNAME:$PASSWORD | chpasswd
chsh -s /usr/bin/zsh $USERNAME

echo "$USERNAME ALL=(ALL) ALL" >> /etc/sudoers.d/$USERNAME

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
