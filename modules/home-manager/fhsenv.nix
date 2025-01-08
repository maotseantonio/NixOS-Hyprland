{
  pkgs,
  config,
  inputs,
  ...
}: {
  home.packages = [
    (let
      base = pkgs.appimageTools.defaultFhsEnvArgs;
    in
      pkgs.buildFHSEnv (base
        // {
          name = "fhs";
          targetPkgs = pkgs:
            (base.targetPkgs pkgs)
            ++ (
              with pkgs; [
                pkg-config
                ncurses
              ]
            );
          profile = "export FHS=1";
          runScript = "bash";
          extraOutputsToInstall = ["dev"];
        }))
  ];
}
