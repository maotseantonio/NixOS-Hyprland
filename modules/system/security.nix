{
  pkgs,
  config,
  host,
  username,
  options,
  lib,
  inputs,
  system,
  ...
}:
{  
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.pam.services.hyprlock = {
    text = ''
      auth include login
    '';
  };
  security.pam.services.swaylock = {
  text = ''
      auth include login
    '';
  };
}
