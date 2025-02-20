{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.drivers.nvidia;
in {
  options.drivers.nvidia = {
    enable = mkEnableOption "Enable Nvidia Drivers";
  };

  config = mkIf cfg.enable { 
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau
        libvdpau-va-gl
        nvidia-vaapi-driver
        vdpauinfo
        libva
        libva-utils
      ];
    };

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      nvidiaPersistenced = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };
}
