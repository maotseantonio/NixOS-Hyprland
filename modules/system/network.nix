{
  pkgs,
  pkgs-master,
  config,
  host,
  username,
  options,
  lib,
  inputs,
  system,
  ...
}: {
  networking.networkmanager.enable = true;
  networking.networkmanager.package = pkgs.pkgs-master.networkmanager;
  networking.hostName = "${host}";
  networking.timeServers = options.networking.timeServers.default ++ ["pool.ntp.org"];
}
