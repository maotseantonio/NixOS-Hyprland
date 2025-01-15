{
  inputs,
  pkgs,
  ...
}: #let
#ghostty = inputs.ghostty.packages.x86_64-linux.default;
#in
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
    background-opacity = 0.9

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
    background = #181825
    foreground = #585b70

    palette = 0=#45475a
    palette = 1=#f38ba8
    palette = 2=#a6e3a1
    palette = 3=#f9e2af
    palette = 4=#89b4fa
    palette = 5=#f5c2e7
    palette = 6=#94e2d5
    palette = 7=#bac2de
    palette = 8=#585b70
    palette = 9=#f38ba8
    palette = 10=#a6e3a1
    palette = 11=#f9e2af
    palette = 12=#89b4fa
    palette = 13=#f5c2e7
    palette = 14=#94e2d5
    palette = 15=#a6adc8 
    background = #181825
    foreground = #cdd6f4
    cursor-color = #f38ba8
    selection-background = #353749
    selection-foreground = #cdd6f4
  '';
}
