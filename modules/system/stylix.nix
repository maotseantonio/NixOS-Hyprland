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
let
  # Oxocarbon color palette
  oxocarbon = {
    base00 = "161616"; # background
    base01 = "262626"; # lighter background
    base02 = "393939"; # selection background
    base03 = "525252"; # comments, invisibles
    base04 = "dde1e6"; # dark foreground
    base05 = "f2f4f8"; # default foreground
    base06 = "ffffff"; # light foreground
    base07 = "08bdba"; # cyan
    base08 = "3ddbd9"; # light cyan
    base09 = "78a9ff"; # blue
    base0A = "ee5396"; # magenta
    base0B = "33b1ff"; # light blue
    base0C = "ff7eb6"; # light magenta
    base0D = "42be65"; # green
    base0E = "be95ff"; # violet
    base0F = "82cfff"; # orange
  };
in
{
  stylix.enable = true;
  stylix.autoEnable = false;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";
  stylix = {
      targets = {
          gtk.enable = true;
          nixos-icons.enable = true;
          #kitty.enable = true;
          #ghostty.enable = true;
          #wezterm.enable = true;
      };
  };
  stylix.polarity = "dark";
  stylix.image = "/home/antonio/Pictures/wallpapers/Catpuccin_carv1.png";
  stylix = {
    fonts = {
      sizes = {
        terminal = 14;
        applications = 12;
        popups = 12;
      };

      serif = {
        name = "CaskaydiaCove Nerd Font";
        package = pkgs.nerd-fonts.caskaydia-cove;
      };

      sansSerif = {
        name = "CaskaydiaCove Nerd Font";
        package = pkgs. nerd-fonts.caskaydia-cove;
      };

      monospace = {
        package = pkgs. nerd-fonts.caskaydia-cove;
        name = "CaskaydiaCove Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
