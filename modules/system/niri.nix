{
    config,
    pkgs,
    lib,
    ...
}:
{
    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };
}
