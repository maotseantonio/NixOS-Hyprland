{ pkgs, config, host, username, options, lib, inputs, system, ... }:
{
   fonts.packages = with pkgs; [
    noto-fonts
    fira-code
    noto-fonts-cjk-sans
    jetbrains-mono
    material-icons
    sf-mono-liga-bin
    #iosevka-bin
    font-awesome
    terminus_font
    nerd-fonts.monaspace
    nerd-fonts.jetbrains-mono 
    
 	];
}