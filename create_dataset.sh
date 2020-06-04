#!/bin/bash

zfs create -o mountpoint=none zroot/data
zfs create -o mountpoint=none zroot/ROOT
zfs create -o mountpoint=/ -o canmount=noauto zroot/ROOT/default
zfs create -o mountpoint=/home zroot/data/home
zfs create -o mountpoint=/root zroot/data/home/root

zfs create -o mountpoint=/var -o canmount=off     zroot/var
zfs create                                        zroot/var/log
zfs create -o mountpoint=/var/lib -o canmount=off zroot/var/lib
zfs create                                        zroot/var/lib/libvirt
zfs create                                        zroot/var/lib/docker


zpool export zroot
rm -r /mnt*


# mount pool
zpool import -d /dev/disk/by-id -R /mnt zroot -N
zfs load-key zroot

zfs mount zroot/ROOT/default
zfs mount -a
zpool set bootfs=zroot/ROOT/default zroot
zpool set cachefile=/etc/zfs/zpool.cache zroot
mkdir -p /mnt/etc/zfs/
cp /etc/zfs/zpool.cache /mnt/etc/zfs/zpool.cache