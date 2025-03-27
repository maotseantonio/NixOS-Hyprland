{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      alefragnani.project-manager
      #astro-build.astro-vscode
      leonardssh.vscord
      bradlc.vscode-tailwindcss
      christian-kohler.npm-intellisense
      christian-kohler.path-intellisense
      dbaeumer.vscode-eslint
      eamodio.gitlens
      editorconfig.editorconfig
      esbenp.prettier-vscode
      formulahendry.auto-close-tag
      formulahendry.code-runner
      golang.go
      jnoortheen.nix-ide
      meganrogge.template-string-converter
      mikestead.dotenv
      mkhl.direnv
      ms-azuretools.vscode-docker
      naumovs.color-highlight
      oderwat.indent-rainbow
      redhat.vscode-yaml
      svelte.svelte-vscode
      tamasfe.even-better-toml
      usernamehw.errorlens
      yzhang.markdown-all-in-one
            #catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      ms-vscode.live-server
      visualstudioexptteam.vscodeintellicode
    ];
    keybindings = [
      {
        "key" = "ctrl+`";
        "command" = "workbench.action.terminal.focus";
        "when" = "editorTextFocus";
      }
      {
        "key" = "ctrl+`";
        "command" = "workbench.action.focusActiveEditorGroup";
        "when" = "terminalFocus";
      }
      {
        "key" = "alt+f";
        "command" = "editor.action.formatDocument";
        "when" = "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor";
      }
    ];
    userSettings = let
      general = {
        "extensions.autoCheckUpdates" = false;
        "extensions.autoUpdate" = false;
        "update.mode" = "none";
        "update.showReleaseNotes" = false;
        "redhat.telemetry.enabled" = false;
        "telemetry.telemetryLevel" = "off";
      };

      window = {
        "window.dialogStyle" = "custom";
        "window.titleBarStyle" = "custom";
      };

      files = {
        "files.autoSave" = "onWindowChange";
        "files.insertFinalNewline" = true;
        "files.trimTrailingWhitespace" = true;
      };

      editor = {
        "editor.bracketPairColorization.enabled" = true;
        "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
        "editor.cursorBlinking" = "smooth";
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.codeActionsOnSave"."source.fixAll" = "always";
        "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', monospace";
        "editor.fontLigatures" = true;
        "editor.fontSize" = 17;
        "editor.fontWeight" = "600";
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.formatOnType" = true;
        "editor.guides.bracketPairs" = "active";
        "editor.guides.bracketPairsHorizontal" = "active";
        "editor.guides.indentation" = true;
        "editor.inlayHints.enabled" = "on";
        "editor.inlayHints.padding" = true;
        "editor.inlineSuggest.enabled" = true;
        "editor.linkedEditing" = true;
        "editor.lineNumbers" = "on";
        "editor.minimap.enabled" = false;
        "editor.parameterHints.enabled" = true;
        "editor.scrollbar.horizontal" = "hidden";
        "editor.semanticHighlighting.enabled" = true;
        "editor.showUnused" = true;
        "editor.snippetSuggestions" = "top";
        "editor.stickyScroll.enabled" = true;
        "editor.tabCompletion" = "on";
        "editor.tabSize" = 2;
        "editor.trimAutoWhitespace" = true;
        "editor.wordWrap" = "on";
        "editor.wrappingIndent" = "indent";
        "window.menuBarVisibility" = "toggle";
      };

      workbench = {
        "workbench.activityBar.location" = "bottom";
        "workbench.editor.empty.hint" = "hidden";
        "workbench.sideBar.location" = "left";
        "workbench.startupEditor" = "none";
        "workbench.editor.showTabs" = "single";
        "workbench.tree.indent" = 16;
        "workbench.statusBar.visible" = false;
        "workbench.layoutControl.type" = "menu";
        "editor.scrollbar.vertical" = "hidden";
        "editor.scrollbar.horizontal" = "hidden";
        "workbench.layoutControl.enabled" = false;
      };

      terminal = {
        "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font Mono', 'monospace', monospace";
        "terminal.integrated.fontSize" = 16;
        "terminal.integrated.gpuAcceleration" = "on";
        "terminal.integrated.minimumContrastRatio" = 1;
      };

      theme = {
        "workbench.colorTheme" = "Catppuccin Mocha";
        "workbench.iconTheme" = "catppuccin-mocha";
                #"catppuccin.accentColor" = "blue";
        "catppuccin.bracketMode" = "rainbow";
        "catppuccin.workbenchMode" = "default";
        "catppuccin.boldKeywords" = true;
        "catppuccin.italicKeywords" = true;
        "catppuccin.italicComments" = true;
        "catppuccin.syncWithIconPack" = true;
        "catppuccin.extraBordersEnabled" = false;
      };

      # Extension settings
      extension = {
        # git
        "git.autofetch" = true;
        "git.enableCommitSigning" = true;
        "git.enableSmartCommit" = true;
        "git.openRepositoryInParentFolders" = "always";

        # errorLens
        "errorLens.gutterIconsEnabled" = true;
        "errorLens.gutterIconSet" = "defaultOutline";

        # eslint
        "eslint.format.enable" = true;
        "eslint.problems.shortenToSingleLine" = true;
        "eslint.validate" = [
          "javascript"
          "typescript"
          "javascriptreact"
          "typescriptreact"
          "astro"
          "svelte"
        ];

        # prettier
        "prettier.jsxSingleQuote" = true;

        # svelte
        "svelte.enable-ts-plugin" = true;
      };

      # Formatter settings
      formatter = {
        "[astro]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[css]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[json]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[jsonc]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[markdown]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[nix]"."editor.defaultFormatter" = "jnoortheen.nix-ide";
        "[scss]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[svelte]"."editor.defaultFormatter" = "svelte.svelte-vscode";
        "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[typescriptreact]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      };

      # Language specific settings
      language = {
        # go
        "go.alternateTools" = {
          "delve" = "${pkgs.delve}/bin/dlv";
          "gofumpt" = "${pkgs.gofumpt}/bin/gofumpt";
          "golangci-lint" = "${pkgs.golangci-lint}/bin/golangci-lint";
          "gomodifytags" = "${pkgs.gomodifytags}/bin/gomodifytags";
          "gopls" = "${pkgs.gopls}/bin/gopls";
          "impl" = "${pkgs.impl}/bin/impl";
          "staticcheck" = "${pkgs.go-tools}/bin/staticcheck";
        };
        "go.inlayHints.assignVariableTypes" = true;
        "go.inlayHints.compositeLiteralFields" = true;
        "go.inlayHints.compositeLiteralTypes" = true;
        "go.inlayHints.constantValues" = true;
        "go.inlayHints.functionTypeParameters" = true;
        "go.inlayHints.parameterNames" = true;
        "go.inlayHints.rangeVariableTypes" = true;
        "go.lintTool" = "golangci-lint";
        "go.useLanguageServer" = true;
        "gopls" = {
          "formatting.gofumpt" = true;
          "ui.semanticTokens" = true;
        };
        "emeraldwalk.runonsave" = {
          "commands" = [
            {
              "cmd" = "${pkgs.goimports-reviser}/bin/goimports-reviser -rm-unused -set-alias -format -use-cache -output write \${file}";
              "match" = "\\.go$";
            }
            {
              "cmd" = "${pkgs.golines}/bin/golines \${file} -w";
              "match" = "\\.go$";
            }
          ];
        };

        # javascript
        "javascript.inlayHints.functionLikeReturnTypes.enabled" = true;
        "javascript.inlayHints.parameterNames.enabled" = "all";
        "javascript.inlayHints.parameterTypes.enabled" = true;
        "javascript.inlayHints.propertyDeclarationTypes.enabled" = true;
        "javascript.preferGoToSourceDefinition" = true;
        "javascript.suggest.completeFunctionCalls" = true;

        # nix
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "${pkgs.nil}/bin/nil";
        "nix.serverSettings"."nil"."formatting"."command" = ["${pkgs.alejandra}/bin/alejandra"];

        # typescript
        "typescript.inlayHints.functionLikeReturnTypes.enabled" = true;
        "typescript.inlayHints.parameterNames.enabled" = "all";
        "typescript.inlayHints.parameterTypes.enabled" = true;
        "typescript.inlayHints.propertyDeclarationTypes.enabled" = true;
        "typescript.preferGoToSourceDefinition" = true;
        "typescript.suggest.completeFunctionCalls" = true;
      };
    in
      general
      // window
      // files
      // editor
      // workbench
      // terminal
      // theme
      // extension
      // formatter
      // language;
  };
}
