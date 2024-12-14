{ pkgs, config, host, username, options, lib, inputs, system, ... }:
{
  networking.networkmanager.enable = true;
  networking.hostName = "${host}";
  networking.timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];

}