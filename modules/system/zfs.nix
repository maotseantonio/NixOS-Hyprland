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
   networking.hostId = "6f6be4ee";
   boot.supportedFilesystems = [ "zfs" ];
   boot.initrd.supportedFilesystems = [ "zfs" ];
   boot.zfs.devNodes = "/dev/disk/by-partuuid";
   boot.zfs.package = pkgs.zfs_cachyos;
   #boot.zfs.package = pkgs.zfs;
   services.zfs = {
      autoSnapshot= {
        enable = true;
        flags = "-k -p --utc";
        monthly = 0;
        weekly = 2;
        daily = 6;
        hourly = 0;
        frequent = 0;
      };
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
