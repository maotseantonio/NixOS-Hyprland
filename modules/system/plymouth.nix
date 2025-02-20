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
  cfg = config.system.plymouth;
in {
  options.system.plymouth = {
    enable = mkEnableOption "Enable plymouth";
  };

  config = mkIf cfg.enable {
    #catppuccin.tty.enable = true;
    catppuccin.plymouth.enable = true;
    catppuccin.plymouth.flavor = "mocha";
    boot = {
      plymouth.enable = true;
    };
  };
}
