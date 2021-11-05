#!/bin/bash

pacman -S gnome gdm

systemctl enable gdm.service

echo Done!
