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
      wl-clip-persist
      cliphist
      xwayland-satellite
      wl-clipboard
      gnome-control-center
      catppuccin-cursors.mochaGreen
    ];
  };
}
