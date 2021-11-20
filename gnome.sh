#!/bin/bash

pacman -S --noconfirm  gnome gdm

systemctl enable gdm.service

echo Done!
