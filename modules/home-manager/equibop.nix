{
    lib,
    pkgs,
    config,
    inputs,
    ...
}:
{
    home.packages = with pkgs; [pkgs-master.equibop];
    
    xdg.configFile."equibop/settings.json".text = ''
    {
        "MINIMIZE_TO_TRAY": true,
        "arRPC": false,
        "discordBranch": "canary",
        "splashBackground": "rgb(30, 30, 46)",
        "splashColor":"rgb(186, 194, 222)",
        "splashTheming": true,
        "staticTitle": false,
        "splashAnimationPath": "/home/antonio/Downloads/nso-needy-streamer.gif",
        "clickTrayToShowHide": true
    }

    '';
}
