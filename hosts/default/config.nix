# Main default config
{ config, pkgs, host, username, options, lib, inputs, system, ...}: let
  
  inherit (import ./variables.nix) keyboardLayout;
  python-packages = pkgs.python3.withPackages (
    ps:
      with ps; [
        requests
        pyquery # needed for hyprland-dots Weather script
        ]
    );
  
  in {
  imports = [
    ./hardware.nix
    ./users.nix
    ../../modules/system/desktop.nix

  ];
       
  nixpkgs.overlays = [
    (final: prev: {
        sf-mono-liga-bin = prev.stdenvNoCC.mkDerivation rec {
        pname = "sf-mono-liga-bin";
        version = "dev";
        src = inputs.sf-mono-liga-src;
        dontConfigure = true;
        installPhase = ''
            mkdir -p $out/share/fonts/opentype
            cp -R $src/*.otf $out/share/fonts/opentype/
            '';
        };
     }) 
    ];  

  drivers.amdgpu.enable = true;
  drivers.intel.enable = false;
  drivers.nvidia.enable = true;
#  drivers.nvidia-prime = {
#    enable = true;
#    intelBusID = "PCI:0:2:0";
#    nvidiaBusID = "PCI:1:0:0";
#  };
  vm.guest-services.enable = false;
  local.hardware-clock.enable = true;
  system.kernel.enable = true;
  system.bootloader.enable = true;
  system.plymouth.enable = true;
  system.audio.enable = true;
  system.greetd.enable = true;
  system.powermanagement.enable = false;
  system.scheduler.enable = false;
  system.btrfs.enable = true;
  system.zfs.enable = true;
  system.zram.enable = true;
  nixpkgs.config.allowUnfree = true;
  users = {
    mutableUsers = true;
  };

  environment.systemPackages = (with pkgs; [
       
    libva-utils
    libvdpau-va-gl
    #intel-compute-runtime
    #intel-vaapi-driver
    vaapiVdpau
    mesa
    egl-wayland
    waybar  # if wanted experimental next line
    #(pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];}))
  ]) ++ [
	  python-packages
  ];
  # OpenGL
  hardware.graphics = {
    enable = true;
  };
  console.keyMap = "${keyboardLayout}";
  # For Electron apps to use wayland
  environment.variables = {
        VDAPU_DRIVER = lib.mkIf config.hardware.graphics.enable (lib.mkDefault "va_gl");
    };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables = {
  EDITOR = "nvim";
  BROWSER = "firefox";
  TERMINAL = "wezterm";
  VISUAL = "vscodium";
  GSK_RENDERER = "gl";
};
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}

