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
    #./helix.nix
    ./fhsenv.nix
    ./nvchad.nix
    #./nvim.nix
    #./nixvim.nix
    ./textfox.nix
    ./nixcord.nix
    ./hyprland.nix
    ./spicetify.nix
    ./vscodium.nix
    ./home-packages.nix
    ./ghostty.nix
    ./hyprpanel.nix
    ./variables.nix
    ./zathura.nix
    ./hypridle.nix
    #  ./anyrun/anyrun.nix
    ./zellij/default.nix
    ./scripts/scripts.nix
  ];
}
