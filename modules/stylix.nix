{ pkgs, config, host, username, options, lib, inputs, system, ... }:
{
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/mocha.yaml";
  stylix.targets.spicetify.enable = true;
  stylix.targets.gtk.enable = true;
  stylix.targets.fish.enable = true;
}