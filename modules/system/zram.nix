{
  config,
  lib,
  inputs,
  username,
  ...
}: 
with lib; let
  cfg = config.system.zram;
in  {
  options.system.zram = {
    enable = mkEnableOption "Enable zramSwap Modules";
  };

  config = mkIf cfg.enable {

    zramSwap = {
        enable = true;
        priority = 100;
        memoryPercent = 200;
        swapDevices = 1;
        algorithm = "zstd";
    };
 };
}
