{
  config,
  lib,
  inputs,
  username,
  pkgs,
  ...
}: 
with lib; let
  cfg = config.system.zfs;
in  {
  options.system.zfs = {
    enable = mkEnableOption "Enable ZFS Modules";
  };

  config = mkIf cfg.enable {
   ### Useful ZFS maintenance ###
   networking.hostId = "1681f325";
   boot.supportedFilesystems = [ "zfs" ];
   boot.initrd.supportedFilesystems = [ "zfs" ];
   boot.zfs.devNodes = "/dev/disk/by-partuuid";
   boot.zfs.package = pkgs.zfs_cachyos;
   services.zfs = {
      autoScrub = {
        enable = true;
        interval = "weekly";
      };
      trim = {
        enable = true;
        interval = "weekly";
      };
    };

 };
}
