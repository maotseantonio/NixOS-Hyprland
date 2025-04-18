{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./home.nix
    ./git.nix
   #./gtk.nix
   ./nixy.nix
    ./fhsenv.nix
    ./nvchad.nix
    ./textfox.nix
   #./nixcord.nix
    ./hyprland-desktop.nix
   ./spicetify.nix
    ./vscodium.nix
    ./desktop-packages.nix
    ./ghostty.nix
    #./walker.nix
    ./hypridle.nix
    ./variables.nix
    ./niri/default.nix
    ./zellij/default.nix
    ./scripts/scripts.nix
  ];
}
