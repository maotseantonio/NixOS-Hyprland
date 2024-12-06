{ inputs, pkgs, ... }:
{
 # imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

  systemd.services.flatpak-repo = {
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };


}
