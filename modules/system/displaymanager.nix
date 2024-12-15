{ pkgs, config, host, username, options, lib, inputs, system, ... }:
with lib;
let
  cfg = config.system.displayManager;
in
{
  options.system.displayManager = {
    enable = mkEnableOption "Enable Display Manager Services";
  };

config = mkIf cfg.enable{
  services.displayManager.defaultSession = "hyprland";
  services.displayManager.sddm = {
      enable = true; # Enable SDDM.
      wayland.enable = true;
      theme = "catppuccin-sddm-corners";
     settings = {
        Theme = {
            CursorTheme = "Bibata-Modern-Ice";    
        };
      };
    };
  programs.uwsm.enable = true; 
  programs.uwsm.waylandCompositors = {
      hyprland = {
          prettyName = "Hyprland";
          comment = "Hyprland compositor manager by UWSM";
          binPath = "/run/current-system/sw/bin/Hyprland";
      };
  };
 };
}
