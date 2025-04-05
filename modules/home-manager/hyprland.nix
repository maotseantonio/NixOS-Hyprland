{
  config,
  pkgs,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
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
    source= $UserConfigs/Laptops.conf
    source= $UserConfigs/LaptopDisplay.conf
    source= $UserConfigs/WindowRules.conf
    source= $UserConfigs/UserDecorAnimations.conf
    source= $UserConfigs/UserKeybinds.conf
    source= $UserConfigs/UserSettings.conf
    source= $UserConfigs/WorkspaceRules.conf
    source= $HOME/.config/hypr/themes/mocha.conf
  '';
  wayland.windowManager.hyprland.settings.exec-once = [
        "uwsm finalize"
        "${pkgs.hyprpanel}/bin/hyprpanel"
  ];
  wayland.windowManager.hyprland = {
    plugins = [
            inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.borders-plus-plus
            inputs.hyprscroller.packages.${pkgs.stdenv.hostPlatform.system}.hyprscroller
             # (pkgs.pkgs-master.hyprlandPlugins.hyprscroller.overrideAttrs {
             #   src = pkgs.fetchFromGitHub {
             #     owner = "dawsers";
             #     repo = "hyprscroller";
             #     rev = "3f86916f3e9a583154b1be0af4e8a1ef1f7435b2";
             #     hash = "sha256-OYCcIsE25HqVBp8z76Tk1v+SuYR7W1nemk9mDS9GHM8=";
             #     };
             #  })
            #pkgs.pkgs-master.hyprlandPlugins.borders-plus-plus
            #pkgs.pkgs-master.hyprlandPlugins.hyprscroller
    ];
  };
}
