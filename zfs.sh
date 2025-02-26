#!/usr/bin/env sh
set -o errexit

# Create EFI.
mkfs.vfat -F32 /dev/nvme0n1p1

# Swaps.
mkswap /dev/nvme0n1p3 # (TODO)
swapon /dev/nvme0n1p3 # (TODO)

# Create pool.
zpool create -f zroot /dev/nvme0n1p2
zpool set autotrim=on zroot
zfs set compression=zstd zroot
zfs set mountpoint=none zroot
zfs create -o refreservation=8G -o mountpoint=none zroot/reserved

# System volumes.
zfs create -o mountpoint=none zroot/data
zfs create -o mountpoint=none zroot/ROOT
zfs create -o mountpoint=legacy zroot/ROOT/empty
zfs create -o mountpoint=legacy zroot/ROOT/nix
zfs create -o mountpoint=legacy zroot/ROOT/residues # TODO: Move to zroot/ROOT
zfs create -o mountpoint=legacy zroot/data/persistent
zfs create -o mountpoint=legacy zroot/data/choamskies

# Different recordsize
zfs create -o mountpoint=legacy -o recordsize=16K \
	-o compression=off zroot/data/btdownloads
zfs create -o mountpoint=none -o recordsize=1M zroot/games
zfs create -o mountpoint=legacy zroot/games/home
zfs create -o mountpoint=legacy -o recordsize=16K \
	-o logbias=latency zroot/data/postgres

# Init structure
mount -t zfs zroot/ROOT/empty /mnt
mkdir -p /mnt/nix /mnt/var/persistent /mnt/var/residues /mnt/boot \
	/mnt/home/antonio/Games /mnt/home/antonio/Torrents \
	/mnt/home/choamskies
zfs snapshot zroot/ROOT/empty@start

# Mount & Permissions
mount /dev/nvme0n1p1 /mnt/boot
chmod 700 /mnt/boot
mount -t zfs zroot/ROOT/nix /mnt/nix
mount -t zfs zroot/data/choamskies /mnt/home/choamskies
chown 1002:100 /mnt/home/choamskies
chmod 0700 /mnt/home/choamskies
mount -t zfs zroot/games/home /mnt/home/antonio/Games
mount -t zfs zroot/data/btdownloads /mnt/home/antonio/Torrents
chown -R 1001:100 /mnt/home/antonio
chmod 0750 /mnt/home/antonio/Games
mount -t zfs zroot/data/persistent /mnt/var/persistent
mount -t zfs zroot/ROOT/residues /mnt/var/residues

# Podman
sudo zfs create -o mountpoint=none -o canmount=on zroot/containers

echo "Finished. But you\'ll need to set the postgresql volume permission and ownership eventually."
echo "$(head -c 8 /etc/machine-id)"
