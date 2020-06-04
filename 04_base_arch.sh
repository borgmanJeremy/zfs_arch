#!/bin/bash
pacstrap /mnt base linux linux-firmware
cp -R ../ /mnt/tmp
arch-chroot /mnt