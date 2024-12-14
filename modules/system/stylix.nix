{ pkgs, config, host, username, options, lib, inputs, system, ... }:
{
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/mocha.yaml";
  stylix.targets.spicetify.enable = true;
  stylix.targets.gtk.enable = true;
  stylix.targets.fish.enable = true;
  stylix = {
      fonts = {
          sizes = {
          terminal = 14;
          applications = 12;
          popups = 12;
        };

        serif = {
          name = "JetBrainsMono Nerd Font";
          package = pkgs.nerd-font.jetbrainsmono;
        };

        sansSerif = {
          name = "JetBrainsMono Nerd Font";
          package = pkgs.nerd-font.jetbrainsmono;
        };

        monospace = {
          package = pkgs.nerd-font.jetbrainsmono;
          name = "JetBrainsMono Nerd Font";
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
      };
  };
}
