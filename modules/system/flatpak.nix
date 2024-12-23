{ inputs, pkgs, lib, system,... }:

{
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];
  services = {
    flatpak = {
     enable = true;
     packages = [
      "com.github.tchx84.Flatseal"
     ];
    };
  };
  systemd.services.flatpak-repo = {
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}

