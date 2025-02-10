#########btrfs-partition
export DRIVE=nvme0n1
export BOOT_PARTITION="${DRIVE}p1"
export ROOT_PARTITION="${DRIVE}p2"
export SWAP_PARTITION="${DRIVE}p3"

zpool create -O compression=on -O mountpoint=none -O xattr=sa -O acltype=posixacl -o ashift=12 rpool /dev/nvme0n1p2

zfs create -p -o mountpoint=legacy rpool/local/root
zfs create -p -o mountpoint=legacy rpool/local/nix
zfs create -p -o mountpoint=legacy rpool/safe/home
zfs create -p -o mountpoint=legacy rpool/safe/persist

mkfs.fat -F 32 -n boot /dev/nvme0n1p1
mkswap -L swap /dev/nvme0n1p3
mount -t zfs rpool/local/root /mnt
mkdir /mnt/{home,nix,persist}
mount -t zfs rpool/local/nix /mnt/nix 
mount -t zfs rpool/safe/home /mnt/home
mount -t zfs rpool/safe/persist /mnt/persist
zfs snapshot rpool/local/root@start
mkdir /mnt/boot
mount /dev/$BOOT_PARTITION /mnt/boot
swapon /dev/$SWAP_PARTITION

nixos-generate-config --root /mnt
echo "umount -Rl /mnt"
echo "zpool export -a"
echo "head -c 8 /etc/machine-id"




