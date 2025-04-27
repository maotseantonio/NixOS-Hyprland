{
  pkgs,
  inputs,
  system,
  config,
  lib,
  options,
  username,
  host,
  ...
}: {
  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      allowed-users = ["root" "@wheel" "antonio"];
      trusted-users = ["root" "@wheel" "antonio" "@builders"];
      warn-dirty = false;
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
