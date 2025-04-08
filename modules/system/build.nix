{pkgs ? import <nixpkgs> {}}: let
  build = pkgs.writeShellApplication {
    name = "build";
    runtimeInputs = [
      pkgs.nvd
      pkgs.nix
      pkgs.git
      pkgs.gawk
      pkgs.alejandra
      pkgs.gum
    ];
    text =
      #sh
      ''
        set -e
        pushd ~/NixOS-Hyprland/


        alejandra . &>/dev/null \
        || ( alejandra . ; gum style --foreground 212 --border-foreground 212 --border double \
        --align center --width 50 --margin "1 2" --padding "2 4" \
        'Formatting failed' && exit 1)

        # Shows your changes
        git diff --color=always -U0 '*.nix' | \
        gum pager --soft-wrap --show-line-numbers || \
        gum style --padding="1 2" --border="rounded" "No .nix file changes"

        CURRENT_GEN=$(readlink -f /run/current-system)

        sudo nixos-rebuild switch --flake .#nvidia-laptop 2>&1 | tee rebuild.log | awk '
        BEGIN {
            in_error = 0
            skip_mode = 0
        }
        {
            # Show progress
            system("")  # Force line buffer flush

            # Check for Nix error patterns (more comprehensive matching)
            if ($0 ~ /(error:|error|build failed|failed with)/) {
                if ($0 ~ /error:[[:space:]]*$/) {
                    # Empty error line - skip until next error
                    skip_mode = 1
                    in_error = 0
                } else {
                    # Valid error message
                    print $0
                    in_error = 1
                    skip_mode = 0
                }
            }
            else if (in_error) {
                if (NF == 0) {  # Blank line ends error
                    print ""
                    in_error = 0
                } else {
                    print $0
                }
            }
            else if (!skip_mode) {
                # Print normal output when not in skip mode
                print $0
            }
        }
        END {
        }'

        NEW_GEN=$(readlink -f /run/current-system)
        nvd diff "$CURRENT_GEN" "$NEW_GEN"
        git add .
        git commit -m "$(gum input --width 50 --placeholder "Commit messege...")" \

        # Back to where you were
        popd
      '';
  };
in
  build
