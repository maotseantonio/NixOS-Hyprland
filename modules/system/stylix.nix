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
}: {
  stylix.enable = true;
  stylix.autoEnable = false;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  stylix.targets.spicetify.enable = true;
  stylix.targets.gtk.enable = true;
  stylix.targets.fish.enable = true;
  stylix.polarity = "dark";
  stylix.targets.nixos-icons.enable = true;
  stylix.image = "/home/antonio/Pictures/wallpapers/luffy1_catppuccin-mocha.png";
  stylix = {
    fonts = {
      sizes = {
        terminal = 14;
        applications = 12;
        popups = 12;
      };

      serif = {
        name = "JetBrainsMono Nerd Font";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };

      sansSerif = {
        name = "JetBrainsMono Nerd Font";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };

      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
