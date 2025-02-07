{
  config,
  lib,
  inputs,
  username,
  ...
}: 
with lib; let
  cfg = config.system.btrfs;
in  {
  options.system.btrfs = {
    enable = mkEnableOption "Enable btrfs Modules";
  };

  config = mkIf cfg.enable {
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = ["/"];
  };

 };
}
