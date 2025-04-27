{
  pkgs,
  config,
  inputs,
  lib,
  options,
  username,
  system,
  host,
  ...
}: {
  chaotic.nyx.cache.enable = true;
  chaotic.nyx.overlay.enable = true;
  nix = {
    settings = {
      substituters = [
        "https://nix-community.cachix.org"
        "https://nyx.chaotic.cx"
        "https://hyprland.cachix.org"
        "https://yazi.cachix.org"
        "https://anyrun.cachix.org"
        # "https://walker.cachix.org"
        "https://walker-git.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
        "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
        "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="

        ];
    };
  };
}
