{
  pkgs,
  config,
  host,
  username,
  options,
  lib,
  inputs,
  system,
  ...
}:
with lib; let
  cfg = config.system.scheduler;
in {
  options.system.scheduler = {
    enable = mkEnableOption "Enable Scheduler Options";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      scx_git.full
    ];
    services.scx = {
        enable = true;
        scheduler = "scx_lavd";
        extraArgs = [ "--autopower" ];
     };
  };
}
