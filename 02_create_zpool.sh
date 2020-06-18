#!/bin/bash
# arg 1 is the disk to create the pool on
zpool create -f -o ashift=12  \
    -O acltype=posixacl       \
    -O relatime=on            \
    -O atime=off              \
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
    $POOL_NAME /dev/disk/by-id/$1