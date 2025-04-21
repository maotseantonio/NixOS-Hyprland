{
  inputs,
  pkgs,
  ...
}: let
        ghostty = inputs.ghostty.packages.x86_64-linux.default;
   in
{
  home.packages = with pkgs; [ghostty];

  xdg.configFile."ghostty/config".text = ''
    # Font
    font-family = JetBrainsMono Nerd Font
    font-size = 14
    font-thicken = true

    bold-is-bright = false
    adjust-box-thickness = 1

    # Theme
    theme = "catppuccin-mocha"
    background-opacity = 0.98

    cursor-style = bar
    cursor-style-blink = true
    adjust-cursor-thickness = 1
    keybind = ctrl+d=new_split:right
    keybind = ctrl+f=new_split:down
    resize-overlay = never
    copy-on-select = false
    confirm-close-surface = false
    mouse-hide-while-typing = true

    window-theme = ghostty
    window-padding-x = 4
    window-padding-y = 6
    window-padding-balance = true
    window-padding-color = background
    window-inherit-working-directory = true
    window-inherit-font-size = true
    window-decoration = false

    gtk-titlebar = false
    gtk-single-instance = true
    gtk-tabs-location = bottom
    gtk-wide-tabs = false

    auto-update = off
  '';
  xdg.configFile."ghostty/themes/catppuccin-mocha".text = ''

        background      = #11121d 
        foreground      = #cdd6f4
        cursor-color    = #e78284
        selection-background = #11121d
        selection-foreground = #cdd6f4
        
        palette = 0=#414868   
        palette = 1=#f7768e   
        palette = 2=#9ece6a   
        palette = 3=#e0af68   
        palette = 4=#7aa2f7   
        palette = 5=#bb9af7   
        palette = 6=#7dcfff   
        palette = 7=#c0caf5   
        palette = 8=#414868   
        palette = 9=#f7768e   
        palette = 10=#9ece6a  
        palette = 11=#e0af68  
        palette = 12=#7aa2f7  
        palette = 13=#bb9af7  
        palette = 14=#7dcfff  
        palette = 15=#c0caf5      
'';
}
