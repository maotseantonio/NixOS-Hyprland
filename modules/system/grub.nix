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
with lib; let
  cfg = config.system.bootloader-grub;
in {
  options.system.bootloader-grub = {
    enable = mkEnableOption "Enable Bootloader Grub";
  };

  config = mkIf cfg.enable {
    catppuccin.grub.enable = true;
    catppuccin.grub.flavor = "mocha";
    boot = {
      loader.efi = {
        canTouchEfiVariables = true;
      };
      loader.timeout = 3;
      loader.systemd-boot = {
        enable = false;
        consoleMode = "auto";
        configurationLimit = 8;
      };
     loader.grub = {
       enable = true;
       devices = ["nodev"];
       efiSupport = true;
       zfsSupport = true;   # Enable ZFS support in GRUB
       memtest86.enable = true;
       extraGrubInstallArgs = ["--bootloader-id=${host}"];
       configurationName = "${host}";
       gfxmodeEfi = "2560x1440";
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
