# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # We want to use the yubikey-agent so disable gnome's ssh-agent
    gnome = prev.gnome.overrideScope (gfinal: gprev: {
      gnome-keyring = gprev.gnome-keyring.overrideAttrs (oldAttrs: {
        configureFlags =
          oldAttrs.configureFlags
          or []
          ++ [
            "--disable-ssh-agent"
          ];
      });
    });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  pkgs-master = final: _prev: {
    pkgs-master = import inputs.nixpkgs-master{
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
