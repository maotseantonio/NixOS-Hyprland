{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];
  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in
    {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle # shuffle+ (special characters are sanitized out of extension names)
      ];
      theme = spicePkgs.themes.text;
    };
}
