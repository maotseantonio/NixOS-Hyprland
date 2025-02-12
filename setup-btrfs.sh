#########btrfs-partition
export DRIVE=nvme0n1
export BOOT_PARTITION="${DRIVE}p1"
export ROOT_PARTITION="${DRIVE}p2"
export SWAP_PARTITION="${DRIVE}p3"

mkfs.fat -F 32 /dev/$BOOT_PARTITION
mkfs.btrfs -f /dev/$ROOT_PARTITION
mkswap /dev/$SWAP_PARTITION

mkdir -p /mnt
mount /dev/$ROOT_PARTITION /mnt
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/nix
btrfs subvolume create /mnt/persist
umount /mnt

mount -o compress=zstd,subvol=root /dev/$ROOT_PARTITION /mnt
mkdir /mnt/{home,nix,persist}
mount -o compress=zstd,subvol=home /dev/$ROOT_PARTITION /mnt/home
mount -o compress=zstd,noatime,subvol=nix /dev/$ROOT_PARTITION /mnt/nix
mount -o compress=zstd,noatime,subvol=persist /dev/$ROOT_PARTITION /mnt/persist
mkdir /mnt/boot
mount /dev/$BOOT_PARTITION /mnt/boot
swapon /dev/$SWAP_PARTITION

nixos-generate-config --root /mnt
