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
      scx-full_git
    ];
    services.scx.enable = true;
    services.scx.scheduler = "scx_rusty";
  };
}
