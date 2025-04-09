# This file defines overlays
{ inputs, ... }:
let
  # This one brings our custom packages from the 'pkgs' directory
  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  pkgs-master = final: _prev: {
    pkgs-master = import inputs.nixpkgs-master {
      system = final.system;
      config.allowUnfree = true;
    };
  };
  pkgs-stable = final: _prev: {
    pkgs-stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

in
{
  # Overlays are very useful to overwrite a package globally which then gets used transitively.
  # So overlays should only be used when a package must be overwritten for all
  # packages which might need to use this derivation override as well.
  #
  # [Read more here](docs/pass-inputs-to-modules.md) and
  # [here](https://nix-community.github.io/home-manager/options.xhtml#opt-nixpkgs.overlays).
  inherit pkgs-master;
  inherit pkgs-stable;
}
