{
  pkgs,
  config,
  inputs,
  ...
}: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    userName = "maotseantonio";
    userEmail = "thetzinantonio@gmail.com";
    lfs = {
        enable = true;
        skipSmudge = true;
      };

    extraConfig = {
        # I don't care about the usage of the term "master"
        # but main is easier to type, so that's that
        init.defaultBranch = "main";

        core = {
          # set delta as the main pager
          pager = "delta";

          # disable the horrendous GUI password prompt
          # for Git when SSH authentication fails
          askPass = "";

          whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
        };
    };

     aliases = {
        br = "branch";
        c = "commit -m";
        ca = "commit -am";
        co = "checkout";
        d = "diff";
        df = "!git hist | peco | awk '{print $2}' | xargs -I {} git diff {}^ {}";
        edit-unmerged = "!f() { git ls-files --unmerged | cut -f2 | sort -u ; }; vim `f`";
        fuck = "commit --amend -m";
        graph = "log --all --decorate --graph";
        ps = "!git push origin $(git rev-parse --abbrev-ref HEAD)";
        pl = "!git pull origin $(git rev-parse --abbrev-ref HEAD)";
        af = "!git add $(git ls-files -m -o --exclude-standard | fzf -m)";
        st = "status";
        hist = ''
            log --pretty=format:"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%C(reset)" --graph --date=relative --decorate --all
        '';
        llog = ''
            log --graph --name-status --pretty=format:"%C(red)%h %C(reset)(%cd) %C(green)%an %Creset%s %C(yellow)%d%Creset" --date=relative
        '';
    }; 
  };
}
