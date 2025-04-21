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

        palette = 0=#51576d    # Dark gray (black)
        palette = 1=#e78284    # Red (error)
        palette = 2=#a6d189    # Green (success)
        palette = 3=#e5c890    # Yellow (warning)
        palette = 4=#8caaee    # Blue (accent)
        palette = 5=#f4b8e4    # Magenta
        palette = 6=#81c8be    # Cyan
        palette = 7=#a5adce    # Light gray (foreground dim)
        palette = 8=#626880    # Bright black (comments)
        palette = 9=#e78284    # Bright red
        palette = 10=#a6d189   # Bright green
        palette = 11=#e5c890   # Bright yellow
        palette = 12=#8caaee   # Bright blue
        palette = 13=#f4b8e4   # Bright magenta
        palette = 14=#81c8be   # Bright cyan
        palette = 15=#b5bfe2   # Bright white (foreground)     
'';
}
