{ pkgs, config, host, username, options, lib, inputs, system, ... }:
with lib;
let
  cfg = config.system.bootloader;
in
{
  options.system.bootloader = {
    enable = mkEnableOption "Enable Bootloader";
  };

config = mkIf cfg.enable {
    boot = {
     loader.efi = {
        canTouchEfiVariables = true;
      };
      loader.timeout = 3;
      loader.grub = {
	    enable = true;
	      devices = [ "nodev" ];
	      efiSupport = true;
	      memtest86.enable = true;
	      extraGrubInstallArgs = [ "--bootloader-id=${host}" ];
	      configurationName = "${host}";
        dedsec-theme = {
          enable = true;
          style = "reaper";
          icon = "color";
          resolution = "1440p";
    };     
  	};
      tmp = {
        useTmpfs = false;
        tmpfsSize = "30%";
      };
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = true;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
      };
      
    };
};
}
