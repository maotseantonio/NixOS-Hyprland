{ pkgs, config, host, username, options, lib, inputs, system, ...}:
{
    imports = [
        ./bootloader.nix
        ./nh.nix
        ./audio.nix
        ./fonts.nix
        ./locale.nix
        ./hardwareconf.nix
        ./stylix.nix
        ./system.nix
        ./services.nix
        ./flatpak.nix
        ./fonts.nix
        ./displaymanager.nix
        ./wayland.nix
        ./network.nix
        ./scheduler.nix
        ./virtualization.nix
        ./stylix.nix
        ./powermanagement.nix
    ];
}
