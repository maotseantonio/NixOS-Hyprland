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
  cfg = config.system.displayManager;
in {
  options.system.displayManager = {
    enable = mkEnableOption "Enable Display Manager Services";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      #  (pkgs.callPackage ../../pkgs/sddm-astronaut-theme.nix {
      #      theme = "cybermonk"; 
      #  })
      pkgs.lyra-cursors
      inputs.hyprddm.packages.${pkgs.system}.default
    ];
    services.xserver.enable = true;
    services.displayManager.defaultSession = "hyprland-uwsm";
    services.displayManager.sddm = {
      enable = true; # Enable SDDM.
      package = pkgs.kdePackages.sddm;
      extraPackages = with pkgs; [
        kdePackages.qtsvg
        kdePackages.qtmultimedia
        kdePackages.qtvirtualkeyboard

      ];
      wayland.enable = true;
      theme = "sddm-astronaut-theme";
      settings = {
        Theme = {
          CursorTheme = "LyraR-cursors";
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
      niri = {
          prettyName = "Niri The Goat";
          comment = "Niri";
          binPath = "/run/current-system/sw/bin/niri-session";
      };
    };
  };
}
