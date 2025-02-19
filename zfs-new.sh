#!/usr/bin/env bash

# For installing NixOS having booted from the minimal USB image.
# To run:
#     bash -c "$(curl https://raw.githubusercontent.com/Red-Flake/red-flake-nix/main/install.sh)"

# e: Exit script immediately if any command returns a non-zero exit status.
# u: Exit script immediately if an undefined variable is used.
# o pipefail: Ensure Bash pipelines return a non-zero status if any command fails.
set -eou pipefail

# make sure this script is run as root (sudo does not work)
if [ "$(id -u)" -ne 0 ]; then
    printf "This script has to run as root (do not use sudo)\n" >&2
    exit 1
elif [ -n "${SUDO_USER:-}" ]; then
    printf "This script has to run as root (not sudo)\n" >&2
    exit 1
fi

# define variables
LOGFILE="/mnt/nixos_install.log"
FLAKE="github:Red-Flake/red-flake-nix"
GIT_REV="main"

# define colors
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
WHITE="\e[37m"
ENDCOLOR="\e[0m"

function colorprint() {
    local color="$1"
    local text="$2"
    local endcolor="\e[0m"
    echo -e "${color}${text}${endcolor}"
}

function log() {
    local level="$1"
    local message="$2"

    case "$level" in
        "ERROR")
            colorprint "$RED" "[$level] $message"
            ;;
        "INFO")
            colorprint "$BLUE" "[$level] $message"
            ;;
        "WARN")
            colorprint "$YELLOW" "[$level] $message"
            ;;
        *)
            echo "[$level] $message"
            ;;
    esac
}

function check_command() {
    local cmd="$1"
    if ! command -v "$cmd" &> /dev/null; then
        log "ERROR" "Command not found: $cmd. Please install it and re-run the script."
        exit 1
    fi
}

function yesno() {
    local prompt="$1"
    while true; do
        read -rp "$prompt [y/n] " yn
        case $yn in
            [Yy]* ) echo "y"; return;;
            [Nn]* ) echo "n"; return;;
            * ) log "INFO" "Please answer yes or no.";;
        esac
    done
}

log "INFO" "Welcome to the Red Flake installer!"
log "INFO" "The installer will log the installation process to $LOGFILE."

log "WARN" "This script will format the *entire* disk with a 1GB boot partition
(labelled NIXBOOT), 16GB of swap, then allocating the rest to ZFS.

The following ZFS datasets will be created:
    - zroot/root (mounted at / with blank snapshot)
    - zroot/nix (mounted at /nix)
    - zroot/tmp (mounted at /tmp)
    - zroot/persist (mounted at /persist)
    - zroot/cache (mounted at /cache)"

# Check for required commands
for cmd in blkdiscard sgdisk zpool zfs mkfs.fat mkswap swapon; do
    check_command "$cmd"
done

# Network connectivity check
if ! ping -c 1 github.com &> /dev/null; then
    log "ERROR" "Network connectivity check failed. Please ensure you have an active internet connection."
    exit 1
fi

# Check if in a VM
# Function to detect if running in a VM
is_vm() {
    if [[ -b "/dev/vda" ]]; then
        return 0
    fi

    # Check DMI system information for virtualization
    if grep -qE '(QEMU|VirtualBox|VMware|KVM|Hyper-V|vServer)' /sys/class/dmi/id/modalias 2>/dev/null; then
        return 0
    fi

    # Check if the hypervisor is reported by CPU info
    if grep -q 'hypervisor' /proc/cpuinfo 2>/dev/null; then
        return 0
    fi

    return 1
}

# Select the appropriate disk based on the environment
if is_vm; then
    log "INFO" "VM was detected!"

    # Detect disk based on VM storage scheme
    if [[ -b "/dev/vda" ]]; then
        DISK="/dev/vda"
    elif [[ -b "/dev/sda" ]]; then
        DISK="/dev/sda"
    else
        log "ERROR" "No suitable VM disk detected. Exiting."
        exit 1
    fi

    log "INFO" "Detected disk: ${DISK}"
    do_format=$(yesno "Will now install Red-Flake to ${DISK}. This irreversibly formats the entire disk. Are you sure?")
    if [[ $do_format == "n" ]]; then
        exit
    fi

    # Partitions in VM scheme
    BOOTDISK="${DISK}3"
    SWAPDISK="${DISK}2"
    ZFSDISK="${DISK}1"
else
    log "INFO" "No VM detected. Your attached storage devices will now be listed."
    read -p "Press enter to continue." NULL

    printf "\n"

    log "INFO" "Detected the following devices:"
    lsblk

    printf "\n"

    read -p "Which device do you wish to install on? " DISKINPUT
    DISK="/dev/${DISKINPUT}"

    if [ ! -b "$DISK" ]; then
        log "ERROR" "Device $DISK does not exist."
        exit 1
    fi

    # Partitions in non-VM scheme
    BOOTDISK="${DISK}p3"
    SWAPDISK="${DISK}p2"
    ZFSDISK="${DISK}p1"

    log "INFO" "Boot Partition: $BOOTDISK"
    log "INFO" "SWAP Partition: $SWAPDISK"
    log "INFO" "ZFS Partition: $ZFSDISK"

    do_format=$(yesno "Will now install Red-Flake to ${DISK}. This irreversibly formats the entire disk. Are you sure?")
    if [[ $do_format == "n" ]]; then
        exit
    fi
fi

log "INFO" "SWAP size selection"
read -p "How much Swap Size do you want? Enter in GB: " SWAPSIZE

if ! [[ "$SWAPSIZE" =~ ^[0-9]+$ ]] || [[ "$SWAPSIZE" -eq 0 ]]; then
    log "ERROR" "Invalid SWAPSIZE: $SWAPSIZE. Please enter a positive numeric value."
    exit 1
fi

sgdisk -p "$DISK" > /dev/null

log "INFO" "Erasing disk ${DISK} ..."
blkdiscard -f "$DISK"

log "INFO" "Clear partition table on disk ${DISK} ..."
sgdisk --zap-all "$DISK"

log "INFO" "Creating new GPT partition table on disk ${DISK} ..."
sgdisk -o "$DISK"

sgdisk -p "$DISK" > /dev/null

log "INFO" "Creating partitions on disk ${DISK} ..."
sgdisk -n3:1M:+1G -t3:EF00 "$DISK" # boot

log "INFO" "Creating Swap partition with ${SWAPSIZE}GB ..."
sgdisk -n2:0:+${SWAPSIZE}G -t2:8200 "$DISK" # swap

sgdisk -n1:0:0 -t1:BF01 "$DISK" # root(zfs)

log "INFO" "Notifying kernel of partition changes..."
sgdisk -p "$DISK" > /dev/null
sleep 5

log "INFO" "Creating Swap"
mkswap "$SWAPDISK" --label "SWAP"

swapon "$SWAPDISK"

log "INFO" "Creating Boot Disk"
mkfs.vfat "$BOOTDISK" -n NIXBOOT

use_encryption=$(yesno "Use encryption? (Encryption must also be enabled within host config.)")
if [[ $use_encryption == "y" ]]; then
    encryption_options=(-O encryption=aes-256-gcm -O keyformat=passphrase -O keylocation=prompt)
else
    encryption_options=()
fi

log "INFO" "Creating base ZFS pool zroot on disk ${ZFSDISK} ..."
zpool create -f \
    -o ashift=12 \
    -o autotrim=on \
    -O compression=zstd \
    -O acltype=posixacl \
    -O atime=off \
    -O xattr=sa \
    -O normalization=formD \
    -O mountpoint=none \
    -R /mnt \
    "${encryption_options[@]}" \
    zroot "$ZFSDISK"

log "INFO" "Creating /"
zfs create -o mountpoint=none zroot/root
zfs create -o mountpoint=legacy zroot/root/nixos
zfs snapshot zroot/root/nixos@blank

log "INFO" "Enabling automatic snapshots for ZFS pool zroot"
zfs set com.sun:auto-snapshot=true zroot

mount -t zfs zroot/root/nixos /mnt

log "INFO" "Mounting /boot (efi)"
mount --mkdir "$BOOTDISK" /mnt/boot

log "INFO" "Creating /nix"
zfs create -o mountpoint=legacy zroot/nix
mount --mkdir -t zfs zroot/nix /mnt/nix

log "INFO" "Creating /tmp"
zfs create -o mountpoint=legacy zroot/tmp
mount --mkdir -t zfs zroot/tmp /mnt/tmp

log "INFO" "Creating /cache"
zfs create -o mountpoint=legacy zroot/cache
mount --mkdir -t zfs zroot/cache /mnt/cache

log "INFO" "Creating /home"
zfs create -o mountpoint=legacy zroot/home
mount --mkdir -t zfs zroot/home /mnt/home

restore_snapshot=$(yesno "Do you want to restore from a persist snapshot?")
if [[ $restore_snapshot == "y" ]]; then
    read -p "Enter full path to snapshot: " snapshot_file_path
    log "INFO" "Creating /persist"
    zfs receive -o mountpoint=legacy zroot/persist < "$snapshot_file_path"
else
    log "INFO" "Creating /persist"
    zfs create -o mountpoint=legacy zroot/persist
fi

mount --mkdir -t zfs zroot/persist /mnt/persist


while true; do
    read -rp "Which host to install? (kvm / vmware / t580 / vps) " HOST
    case $HOST in
        kvm|vmware|t580|vps ) break;;
        * ) echo "Invalid host. Please select a valid host.";;
    esac
done


## user setup logic based on host

# create /persist/etc/shadow.d
mkdir -p /mnt/persist/etc/shadow.d

# setup users with persistent passwords
# https://reddit.com/r/NixOS/comments/o1er2p/tmpfs_as_root_but_without_hardcoding_your/h22f1b9/
# create a password with for root and $user with:
# mkpasswd -m sha-512 'PASSWORD' | sudo tee -a /persist/etc/shadow.d/root
# set root password
while true; do
    # Prompt for the password
    echo -n "Enter password for user root: "
    stty -echo        # Disable echoing
    read root_password
    stty echo         # Re-enable echoing
    echo              # Move to a new line

    # Prompt for the password confirmation
    echo -n "Confirm password: "
    stty -echo
    read root_password_confirm
    stty echo
    echo              # Move to a new line

    # Check if passwords match
    if [ "$root_password" = "$root_password_confirm" ]; then
        echo "$root_password" | mkpasswd -m sha-512 --stdin | tee -a /mnt/persist/etc/shadow.d/root > /dev/null
        unset root_password root_password_confirm
        echo "Password set successfully."
        break
    else
        echo "Passwords do not match. Please try again."
    fi
done

# Set username based on chosen host
case $HOST in
    kvm | vmware )
        USER="redflake"
        ;;
    t580 )
        USER="pascal"
        ;;
    vps )
        USER="redcloud"
        ;;
    * )
        echo "Invalid host. Please select a valid host."
        ;;
esac

log "INFO" "You chose to install host $HOST. Automatically setting user to $USER."


# setup users with persistent passwords
# https://reddit.com/r/NixOS/comments/o1er2p/tmpfs_as_root_but_without_hardcoding_your/h22f1b9/
# create a password with for root and $user with:
# mkpasswd -m sha-512 'PASSWORD' | sudo tee -a /persist/etc/shadow.d/root
# set user password
while true; do
    # Prompt for the password
    echo -n "Enter password for user $USER: "
    stty -echo        # Disable echoing
    read user_password
    stty echo         # Re-enable echoing
    echo              # Move to a new line

    # Prompt for the password confirmation
    echo -n "Confirm password: "
    stty -echo
    read user_password_confirm
    stty echo
    echo              # Move to a new line

    # Check if passwords match
    if [ "$user_password" = "$user_password_confirm" ]; then
        echo "$user_password" | mkpasswd -m sha-512 --stdin | tee -a /mnt/persist/etc/shadow.d/$USER > /dev/null
        unset user_password user_password_confirm
        echo "Password set successfully."
        break
    else
        echo "Passwords do not match. Please try again."
    fi
done

# Set correct permissions for /persist/etc/shadow.d
chown -R root:shadow /mnt/persist/etc/shadow.d/
chmod -R 640 /mnt/persist/etc/shadow.d/

log "INFO" "Installing Red-Flake with host profile ${HOST} for user ${USER} on disk ${DISK}..."
nixos-install --no-root-password --flake "${FLAKE}/${GIT_REV:-main}#$HOST" --option tarball-ttl 0

log "INFO" "Syncing disk writes..."
sync

log "INFO" "Setting up persistence..."

mkdir -p /mnt/persist/var/lib/

# setup NetworkManager persistence
mkdir -p /mnt/persist/etc/NetworkManager
if [ -d /etc/NetworkManager/system-connections ]; then
    cp -r /etc/NetworkManager/system-connections /mnt/persist/etc/NetworkManager/
fi

mkdir -p /mnt/persist/var/lib/NetworkManager
if [ -d /var/lib/NetworkManager ]; then
    cp /var/lib/NetworkManager/{secret_key,seen-bssids,timestamps} /mnt/persist/var/lib/NetworkManager/
fi


# setup Docker persistence
if [ -d /mnt/var/lib/docker ]; then
    cp -r /mnt/var/lib/docker /mnt/persist/var/lib/docker
fi

# setup LXC / LXD persistence
if [ -d /mnt/var/lib/lxd ]; then
    cp -r /mnt/var/lib/lxd /mnt/persist/var/lib/lxd
fi

# setup ssl certs persistence
mkdir -p /mnt/persist/etc/ssl/
if [ -d /mnt/etc/ssl/certs ]; then
    cp -r /mnt/etc/ssl/certs/ /mnt/persist/etc/ssl/
fi


log "INFO" "Taking initial ZFS snapshot of freshly installed system"
zfs snapshot -r zroot@install

log "INFO" "Unmouting /mnt/boot"
umount -f /mnt/boot

log "INFO" "Unmouting ZFS pools"
zfs umount -a

log "INFO" "Exporting ZFS pools"
zpool export -a

log "INFO" "Installation finished. It is now safe to reboot."

do_reboot=$(yesno "Do you want to reboot now?")
if [[ $do_reboot == "y" ]]; then
    reboot
fi
