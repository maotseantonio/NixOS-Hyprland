{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.niri.homeModules.niri ./settings.nix ./binds.nix ./rules.nix];
  home = {
    packages = with pkgs; [
      seatd
      jaq
      brillo
      qt6.qtwayland
      wl-clip-persist
      cliphist
      xwayland-satellite
      wl-clipboard
      gnome-control-center
      catppuccin-cursors.mochaGreen
    ];
    sessionVariables = {
            #      QT_QPA_PLATFORMTHEME = "kvantum";
      QT_STYLE_OVERRIDE = "kvantum";
      XDG_SESSION_TYPE = "wayland";
    };
  };
}
