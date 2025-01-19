{
  pkgs,
  inputs,
  system,
  config,
  lib,
  options,
  host,
  ...
}: {
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
