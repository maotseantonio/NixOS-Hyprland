{config, pkgs, inputs, ...}:
{
   textfox = {
    enable = true;
    profile = "default";
    config = {
      background = {
        color = "#181825";
      };
       border = {
          color = "#cba6f7";
          width = "3px";
          transition = "1.0s ease";
          radius = "5px";
        };
        displayHorizontalTabs = false;
        displayNavButtons = true;
        newtabLogo = "   __            __  ____          \A   / /____  _  __/ /_/ __/___  _  __\A  / __/ _ \\| |/_/ __/ /_/ __ \\| |/_/\A / /_/  __/>  </ /_/ __/ /_/ />  <  \A \\__/\\___/_/|_|\\__/_/  \\____/_/|_|  ";
        font = { 
          family = "JetBrainsMono Nerd Font";
          size = "15px";
          accent = "#c6a0f6";
        };
         sidebery = {
          margin = "1.0rem";
        };
    };
  };
 
}
