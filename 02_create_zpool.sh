#!/bin/bash
zpool create -f -o ashift=12  \
    -O acltype=posixacl       \
    -O relatime=on            \
    -O xattr=sa               \
    -O dnodesize=legacy       \
    -O normalization=formD    \
    -O mountpoint=none        \
    -O canmount=off           \
    -O devices=off            \
    -R /mnt                   \
    -O compression=lz4        \
    -O encryption=aes-256-gcm \
    -O keyformat=passphrase   \
    -O keylocation=prompt     \
    zroot /dev/disk/by-id/$1