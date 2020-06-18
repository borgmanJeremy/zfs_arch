#!/bin/bash

zfs create -o mountpoint=none                     $SYS_ROOT
zfs create -o mountpoint=none                     $SYS_ROOT/$SYSTEM_NAME
zfs create -o mountpoint=none                     $SYS_ROOT/$SYSTEM_NAME/ROOT
zfs create -o mountpoint=/ -o canmount=noauto     $SYS_ROOT/$SYSTEM_NAME/ROOT/default

# Create home outside root so can be used across boot envs
zfs create -o mountpoint=/home                    $SYS_ROOT/$SYSTEM_NAME/home
zfs create -o mountpoint=/home/$USER              $SYS_ROOT/$SYSTEM_NAME/home/$USER

# These are not mounted and just create the zfs dataset
zfs create -o mountpoint=/var             -o canmount=off -o xattr=sa $SYS_ROOT/$SYSTEM_NAME/var
zfs create -o mountpoint=/var/lib         -o canmount=off             $SYS_ROOT/$SYSTEM_NAME/var/lib
zfs create -o mountpoint=/var/lib/systemd -o canmount=off             $SYS_ROOT/$SYSTEM_NAME/var/lib/systemd
zfs create -o mountpoint=/usr             -o canmount=off             $SYS_ROOT/$SYSTEM_NAME/usr

zfs create -o mountpoint=/var/lib/systemd/coredump   $SYS_ROOT/$SYSTEM_NAME/var/lib/systemd/coredump
zfs create -o mountpoint=/var/log                    $SYS_ROOT/$SYSTEM_NAME/var/log
zfs create -o mountpoint=/var/cache                  $SYS_ROOT/$SYSTEM_NAME/var/cache
zfs create -o mountpoint=/usr/local                  $SYS_ROOT/$SYSTEM_NAME/usr/local
zfs create -o mountpoint=/var/lib/libvirt            $SYS_ROOT/$SYSTEM_NAME/var/lib/libvirt
zfs create -o mountpoint=/var/lib/docker             $SYS_ROOT/$SYSTEM_NAME/var/lib/docker

zfs create -o mountpoint=/var/log/journal          -o acltype=posixacl   $SYS_ROOT/$SYSTEM_NAME/var/log/journal

# Adjust permissions
#zfs allow $USER create,mount,mountpoint,snapshot $SYS_ROOT/$SYSTEM_NAME/home/$USER


zfs umount -a
zpool export $POOL_NAME
rm -r /mnt*

# mount pool
zpool import -d /dev/disk/by-id -R /mnt $POOL_NAME -N
zfs load-key $POOL_NAME

zfs mount $SYS_ROOT/$SYSTEM_NAME/ROOT/default
zfs mount -a
zpool set bootfs=$SYS_ROOT/$SYSTEM_NAME/ROOT/default $POOL_NAME
zpool set cachefile=/etc/zfs/zpool.cache $POOL_NAME


mkdir -p /mnt/etc/zfs/
cp /etc/zfs/zpool.cache /mnt/etc/zfs/zpool.cache

# Gen FSTAB 
# TODO: assumes /dev/sda1
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
genfstab -U -p /mnt >> /mnt/etc/fstab

echo "modify /mnt/etc/fstab to comment out non zfs partitions"