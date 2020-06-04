#!/bin/bash
curl -s https://eoli3n.github.io/archzfs/init | bash
echo "create partition table now with cgdisk"
echo "boot partition should be 512M and labeled ef00"
echo "root partition should be the rest of the drive bf00"