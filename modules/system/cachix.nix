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
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      ];
    };
  };
}
