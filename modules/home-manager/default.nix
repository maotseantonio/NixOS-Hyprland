{ pkgs, config, host, username, options, lib, inputs, system, ...}:
{
  imports = [
    ./home.nix
  ];
}