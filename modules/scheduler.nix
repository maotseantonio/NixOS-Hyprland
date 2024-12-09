{ pkgs, config, host, username, options, lib, inputs, system, ... }:
{
    environment.systemPackages = with pkgs; [
          scx_git.full
    ];
    services.scx.enable = true;
    services.scx.scheduler = "scx_bpfland";
}