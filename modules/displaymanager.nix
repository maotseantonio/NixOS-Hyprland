{ pkgs, config, host, username, options, lib, inputs, system, ... }:
{
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
}