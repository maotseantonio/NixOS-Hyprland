{disks ? ["/dev/nvme0n1"], ...}: {
  disko.devices = {
    disk = {
      nvme1 = {
        device = builtins.elemAt disks 0;
        content = {
          partitions = {
            ESP = {
              content = {
                format = "vfat";
                mountpoint = "/boot";
                type = "filesystem";
              };
              size = "512M";
              type = "EF00";
            };
            zfs = {
              size = "100%";
              content = {
                pool = "zroot";
                type = "zfs";
              };
            };
          };
          type = "gpt";
        };
        type = "disk";
      };
    };
    zpool = {
      zroot = {
        type = "zpool";
        rootFsOptions = {
          "com.sun:auto-snapshot" = "false";
          acltype = "posixacl";
          atime = "off";
          canmount = "off";
          compression = "zstd";
          dedup = "on";
          devices = "off";
          mountpoint = "none";
          xattr = "sa";
        };
        datasets = {
          "data" = {
            options.mountpoint = "none";
            type = "zfs_fs";
          };
          "ROOT" = {
            options.mountpoint = "none";
            type = "zfs_fs";
          };
          "ROOT/empty" = {
            mountpoint = "/";
            options.mountpoint = "legacy";
            postCreateHook = ''
              zfs snapshot zroot/ROOT/empty@start
            '';
            type = "zfs_fs";
          };
          "ROOT/nix" = {
            mountpoint = "/nix";
            options.mountpoint = "legacy";
            type = "zfs_fs";
          };
          "ROOT/residues" = {
            mountpoint = "/var/residues";
            options.mountpoint = "legacy";
            type = "zfs_fs";
          };
          "data/persistent" = {
            mountpoint = "/var/persistent";
            options.mountpoint = "legacy";
            type = "zfs_fs";
          };
          "reserved" = {
            options = {
              mountpoint = "none";
              reservation = "10G";
            };
            type = "zfs_fs";
          };
        };
      };
    };
  };

  # Needed for impermanence
  fileSystems."/var/persistent".neededForBoot = true;
  fileSystems."/var/residues".neededForBoot = true;
}
