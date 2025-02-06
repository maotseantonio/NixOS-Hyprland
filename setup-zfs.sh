#########btrfs-partition
export DRIVE=nvme0n1
export BOOT_PARTITION="${DRIVE}p1"
export ROOT_PARTITION="${DRIVE}p2"
export SWAP_PARTITION="${DRIVE}p3"

printf "label: gpt\n,1080M,U\n,,L\n" | sfdisk /dev/$DRIVE

zpool create rpoll -O mountpoint=none -O atime=off -O compress=zstd acltype=posixacl -o ashift=12 -R /mnt raidz1 /dev/nvme0n1

zfs create -p -o mountpoint=legacy rpool/local/root
zfs create -p -o mountpoint=legacy rpool/local/nix
zfs create -p -o mountpoint=legacy rpool/safe/home
zfs create -p -o mountpoint=legacy rpool/safe/persist

mkfs.fat -F 32 -n boot /dev/nvme0n1p1
mkswap -L swap /dev/nvme0n1p3
swapon /dev/nvme0n1p3
mount -t zfs rpool/local/root /mnt
mkdir /mnt/{home,nix,persist}
mount -t zfs rpool/local/nix /mnt/nix 
mount -t zfs rpool/safe/home /mnt/home
mount -t zfs rpool/safe/persist /mnt/persist

mkdir /mnt/boot
mount /dev/$BOOT_PARTITION /mnt/boot
swapon /dev/$SWAP_PARTITION


nixos-generate-config --root /mnt
