{
  config,
  pkgs,
  inputs,
  ...
}:
let
  pointer = config.home.pointerCursor;
in 
{
  wayland.windowManager.hyprland = {
    enable = true;
    #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    package = pkgs.hyprland;
    xwayland.enable = true;
  };
  wayland.windowManager.hyprland.systemd.enable = false;
  wayland.windowManager.hyprland.extraConfig = ''
    $configs = $HOME/.config/hypr/configs
    source=$configs/Settings.conf
    source=$configs/Keybinds.conf
    $UserConfigs = $HOME/.config/hypr/UserConfigs
    source= $UserConfigs/Startup_Apps.conf
    source= $UserConfigs/ENVariables.conf
    source= $UserConfigs/Monitors.conf
    source= $UserConfigs/WindowRules.conf
    source= $UserConfigs/UserDecorAnimations.conf
    source= $UserConfigs/UserKeybinds.conf
    source= $UserConfigs/UserSettings.conf
    source= $UserConfigs/WorkspaceRules.conf
    source= $HOME/.config/hypr/themes/mocha.conf
  '';

  wayland.windowManager.hyprland.settings.bind = [
    "SUPER, D, exec, ${pkgs.ags_1}/bin/ags -t 'overview' "
  ];
  wayland.windowManager.hyprland.settings.exec-once = [
    "uwsm finalize"
    "${pkgs.hyprpanel}/bin/hyprpanel"
    "hyprctl setcursor ${pointer.name} 32"
    "wl-paste --type text --watch cliphist store"  
    "wl-paste --type image --watch cliphist store" 
  ];
  wayland.windowManager.hyprland = {
    plugins = [
      #inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.borders-plus-plus
      pkgs.hyprlandPlugins.borders-plus-plus
      pkgs.hyprlandPlugins.hyprscroller
    ];
  };
}
