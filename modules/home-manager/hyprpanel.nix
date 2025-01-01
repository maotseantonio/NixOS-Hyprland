# *.nix
{ config, pkgs, inputs, ... }:
{
  imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];
  
  programs.hyprpanel = {

    # Enable the module.
    # Default: false
    enable = true;

    # Automatically restart HyprPanel with systemd.
    # Useful when updating your config so that you
    # don't need to manually restart it.
    # Default: false
    systemd.enable = true;

    # Add '/nix/store/.../hyprpanel' to the
    # 'exec-once' in your Hyprland config.
    # Default: false
    hyprland.enable = true;

    # Fix the overwrite issue with HyprPanel.
    # See below for more information.
    # Default: false
    overwrite.enable = true;

    # Import a specific theme from './themes/*.json'.
    # Default: ""
    theme = "catppuccin_mocha";

    # Configure bar layouts for monitors.
    # See 'https://hyprpanel.com/configuration/panel.html'.
    # Default: null
    layout = {
      "bar.layouts" = {
        "0" = {
          left = [ "dashboard" "windowtitle" "hypridle" "media" ];
          middle = [ "workspaces" ];
          right = [ "systray" "cpu" "clock" "power" ];
        };
      };
    };

    # Configure and theme *most* of the options from the GUI.
    # See './nix/module.nix:103'.
    # Default: <same as gui>
    settings = {
      bar.launcher.autoDetectIcon = false;
      bar.workspaces.show_icons = false;

      menus.clock = {
        time = {
          military = true;
          hideSeconds = true;
        };
        weather.unit = "metric";
      };

      menus.dashboard.directories.enabled = false;
      menus.dashboard.stats.enable_gpu = false;

      theme.bar.transparent = false;

      theme.font = {
        name = "JetBrainsMono Nerd Font";
        size = "16px";
      };
    };
  };
}
