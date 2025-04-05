{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./home.nix
    ./git.nix
    ./cava.nix
    ./nixy.nix
    ./fhsenv.nix
    ./nvchad.nix
    #./textfox.nix
    ./nixcord.nix
    ./hyprland.nix
    ./spicetify.nix
    ./vscodium.nix
    ./home-packages.nix
    ./ghostty.nix
    ./equibop.nix
    ./variables.nix
    ./zathura.nix
    ./hypridle.nix
    ./zellij/default.nix
    ./scripts/scripts.nix
  ];
}
