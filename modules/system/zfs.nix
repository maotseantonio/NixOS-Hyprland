{
  config,
  lib,
  inputs,
  username,
  ...
}: 
with lib; let
  cfg = config.system.zfs;
in  {
  options.system.zfs = {
    enable = mkEnableOption "Enable ZFS Modules";
  };

  config = mkIf cfg.enable {
 # Useful ZFS maintenance
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
