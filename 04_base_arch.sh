#!/bin/bash
pacstrap /mnt base linux linux-firmware
cp -R ../ /mnt/mnt/tmp
arch-chroot /mnt

echo "[archzfs]
Server = http://archzfs.com/$repo/x86_64
Server = http://mirror.sum7.eu/archlinux/archzfs/$repo/x86_64
Server = https://mirror.biocrafting.net/archlinux/archzfs/$repo/x86_64

[archzfs-kernels]
Server = http://end.re/$repo/" >> /mnt/etc/pacman.conf