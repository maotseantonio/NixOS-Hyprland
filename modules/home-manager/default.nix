{ pkgs, config, inputs, ...}:
{
  imports = [
    ./home.nix
    ./git.nix
    ./gtk.nix
    ./nixy.nix 
    ./helix.nix
    ./fhsenv.nix
    ./nvchad.nix
    ./textfox.nix
    ./nixcord.nix
    ./hyprland.nix
    ./spicetify.nix
    ./vscodium.nix
    ./scripts/scripts.nix
  ];
}
