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
  cfg = config.system.greetd;
in {
  options.system.greetd = {
    enable = mkEnableOption "Enable Greetd Display Manager Services";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
         greetd.tuigreet
    ];
    services.greetd = {
    enable = true; 
      vt = 1;
      settings = {
        default_session = {
          user = username;
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --user-menu -w 60 --window-padding 5 --container-padding 5 --remember --remember-session --time --theme 'border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red' --cmd uwsm start hyprland-uwsm.desktop"; 
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
