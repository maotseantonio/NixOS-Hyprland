{ pkgs, config, host, username, options, lib, inputs, system, ... }:
with lib;
let
  cfg = config.system.plymouth;
in
{
  options.system.plymouth = {
    enable = mkEnableOption "Enable plymouth";
  };

config = mkIf cfg.enable {
    boot = {
          
        plymouth.enable = true;
        plymouth.themePackages = [
            pkgs.catppuccin-plymouth
          ];
        plymouth.theme = "catppuccin-macchiato";
    };
  };
}
