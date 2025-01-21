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
    package = pkgs.lix;
    settings = {
      auto-optimise-store = true;
      warn-dirty = false;
            #trusted-users = ["${username}"];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
