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
{
  stylix.enable = true;
  stylix.autoEnable = false;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
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
