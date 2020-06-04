#!/bin/bash
pacstrap /mnt base linux linux-firmware
cp -R ../ /mnt/mnt/tmp

echo '[archzfs]
Server = http://archzfs.com/$repo/x86_64
Server = http://mirror.sum7.eu/archlinux/archzfs/$repo/x86_64
Server = https://mirror.biocrafting.net/archlinux/archzfs/$repo/x86_64 ' << /mnt/etc/pacman.conf

[archzfs-kernels]
Server = http://end.re/$repo/

arch-chroot /mnt

