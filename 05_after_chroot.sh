#!/bin/bash

ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
hwclock --systohc
local-gen
pacman -S zfs-linux