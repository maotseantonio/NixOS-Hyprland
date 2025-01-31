{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
 inherit (config.lib.stylix) colors;
 sesh = pkgs.writeScriptBin "sesh" ''
    #! /usr/bin/env sh

    # Taken from https://github.com/zellij-org/zellij/issues/884#issuecomment-1851136980
    # select a directory using zoxide
    ZOXIDE_RESULT=$(zoxide query --interactive)
    # checks whether a directory has been selected
    if [[ -z "$ZOXIDE_RESULT" ]]; then
    	# if there was no directory, select returns without executing
    	exit 0
    fi
    # extracts the directory name from the absolute path
    SESSION_TITLE=$(echo "$ZOXIDE_RESULT" | sed 's#.*/##')

    # get the list of sessions
    SESSION_LIST=$(zellij list-sessions -n | awk '{print $1}')

    # checks if SESSION_TITLE is in the session list
    if echo "$SESSION_LIST" | grep -q "^$SESSION_TITLE$"; then
    	# if so, attach to existing session
    	zellij attach "$SESSION_TITLE"
    else
    	# if not, create a new session
    	echo "Creating new session $SESSION_TITLE and CD $ZOXIDE_RESULT"
    	cd $ZOXIDE_RESULT
    	zellij attach -c "$SESSION_TITLE"
    fi
  '';
in {
  

      home.packages = [
      pkgs.tmate
      sesh
      pkgs.zjstatus
    ];

    xdg.configFile."zellij/config.kdl".source = ./config.kdl;
    xdg.configFile."zellij/layouts/default.kdl".text = ''
       layout {
    swap_tiled_layout name="vertical" {
        tab max_panes=5 {
            pane split_direction="vertical" {
                pane
                pane { children; }
            }
        }
        tab max_panes=8 {
            pane split_direction="vertical" {
                pane { children; }
                pane { pane; pane; pane; pane; }
            }
        }
        tab max_panes=12 {
            pane split_direction="vertical" {
                pane { children; }
                pane { pane; pane; pane; pane; }
                pane { pane; pane; pane; pane; }
            }
        }
    }

    swap_tiled_layout name="horizontal" {
        tab max_panes=5 {
            pane
            pane
        }
        tab max_panes=8 {
            pane {
                pane split_direction="vertical" { children; }
                pane split_direction="vertical" { pane; pane; pane; pane; }
            }
        }
        tab max_panes=12 {
            pane {
                pane split_direction="vertical" { children; }
                pane split_direction="vertical" { pane; pane; pane; pane; }
                pane split_direction="vertical" { pane; pane; pane; pane; }
            }
        }
    }

    swap_tiled_layout name="stacked" {
        tab min_panes=5 {
            pane split_direction="vertical" {
                pane
                pane stacked=true { children; }
            }
        }
    }

    swap_floating_layout name="staggered" {
        floating_panes
    }

    swap_floating_layout name="enlarged" {
        floating_panes max_panes=10 {
            pane { x "5%"; y 1; width "90%"; height "90%"; }
            pane { x "5%"; y 2; width "90%"; height "90%"; }
            pane { x "5%"; y 3; width "90%"; height "90%"; }
            pane { x "5%"; y 4; width "90%"; height "90%"; }
            pane { x "5%"; y 5; width "90%"; height "90%"; }
            pane { x "5%"; y 6; width "90%"; height "90%"; }
            pane { x "5%"; y 7; width "90%"; height "90%"; }
            pane { x "5%"; y 8; width "90%"; height "90%"; }
            pane { x "5%"; y 9; width "90%"; height "90%"; }
            pane focus=true { x 10; y 10; width "90%"; height "90%"; }
        }
    }

    swap_floating_layout name="spread" {
        floating_panes max_panes=1 {
            pane {y "50%"; x "50%"; }
        }
        floating_panes max_panes=2 {
            pane { x "1%"; y "25%"; width "45%"; }
            pane { x "50%"; y "25%"; width "45%"; }
        }
        floating_panes max_panes=3 {
            pane focus=true { y "55%"; width "45%"; height "45%"; }
            pane { x "1%"; y "1%"; width "45%"; }
            pane { x "50%"; y "1%"; width "45%"; }
        }
        floating_panes max_panes=4 {
            pane { x "1%"; y "55%"; width "45%"; height "45%"; }
            pane focus=true { x "50%"; y "55%"; width "45%"; height "45%"; }
            pane { x "1%"; y "1%"; width "45%"; height "45%"; }
            pane { x "50%"; y "1%"; width "45%"; height "45%"; }
        }
    }

    default_tab_template {
        pane size=2 borderless=true {
            plugin location="file:///nix/store/c9q5b93y64mja1w9xjcb7vkqn7dfjp8p-zjstatus-0.20.1/bin/zjstatus.wasm" {
                format_left   "{mode}#[bg=#1e1e2e] {tabs}"
                format_center ""
                format_right  "#[bg=#1e1e2e,fg=#89b4fa]#[bg=#89b4fa,fg=#181825,bold] #[bg=#313244,fg=#cdd6f4,bold] {session} #[bg=#45475a,fg=#cdd6f4,bold]"
                format_space  ""
                format_hide_on_overlength "true"
                format_precedence "crl"

                border_enabled  "false"
                border_char     "─"
                border_format   "#[fg=#6C7086]{char}"
                border_position "top"

                mode_normal        "#[bg=#a6e3a1,fg=#313244,bold] NORMAL#[bg=#45475a,fg=#a6e3a1]█"
                mode_locked        "#[bg=#585b70,fg=#313244,bold] LOCKED #[bg=#45475a,fg=#585b70]█"
                mode_resize        "#[bg=#f38ba8,fg=#313244,bold] RESIZE#[bg=#45475a,fg=#f38ba8]█"
                mode_pane          "#[bg=#89b4fa,fg=#313244,bold] PANE#[bg=#45475a,fg=#89b4fa]█"
                mode_tab           "#[bg=#b4befe,fg=#313244,bold] TAB#[bg=#45475a,fg=#b4befe]█"
                mode_scroll        "#[bg=#f9e2af,fg=#313244,bold] SCROLL#[bg=#45475a,fg=#f9e2af]█"
                mode_enter_search  "#[bg=#89b4fa,fg=#313244,bold] ENT-SEARCH#[bg=#45475a,fg=#89b4fa]█"
                mode_search        "#[bg=#89b4fa,fg=#313244,bold] SEARCHARCH#[bg=#45475a,fg=#89b4fa]█"
                mode_rename_tab    "#[bg=#b4befe,fg=#313244,bold] RENAME-TAB#[bg=#45475a,fg=#b4befe]█"
                mode_rename_pane   "#[bg=#89b4fa,fg=#313244,bold] RENAME-PANE#[bg=#45475a,fg=#89b4fa]█"
                mode_session       "#[bg=#cba6f7,fg=#313244,bold] SESSION#[bg=#45475a,fg=#cba6f7]█"
                mode_move          "#[bg=#f2cdcd,fg=#313244,bold] MOVE#[bg=#45475a,fg=#f2cdcd]█"
                mode_prompt        "#[bg=#89b4fa,fg=#313244,bold] PROMPT#[bg=#45475a,fg=#89b4fa]█"
                mode_tmux          "#[bg=#fab387,fg=#313244,bold] TMUX#[bg=#45475a,fg=#fab387]█"

                // formatting for inactive tabs
                tab_normal              "#[bg=#45475a,fg=#89b4fa]█#[bg=#89b4fa,fg=#313244,bold]{index} #[bg=#313244,fg=#cdd6f4,bold] {name}{floating_indicator}#[bg=#45475a,fg=#313244,bold]█"
                tab_normal_fullscreen   "#[bg=#45475a,fg=#89b4fa]█#[bg=#89b4fa,fg=#313244,bold]{index} #[bg=#313244,fg=#cdd6f4,bold] {name}{fullscreen_indicator}#[bg=#45475a,fg=#313244,bold]█"
                tab_normal_sync         "#[bg=#45475a,fg=#89b4fa]█#[bg=#89b4fa,fg=#313244,bold]{index} #[bg=#313244,fg=#cdd6f4,bold] {name}{sync_indicator}#[bg=#45475a,fg=#313244,bold]█"

                // formatting for the current active tab
                tab_active              "#[bg=#45475a,fg=#fab387]█#[bg=#fab387,fg=#313244,bold]{index} #[bg=#313244,fg=#cdd6f4,bold] {name}{floating_indicator}#[bg=#45475a,fg=#313244,bold]█"
                tab_active_fullscreen   "#[bg=#45475a,fg=#fab387]█#[bg=#fab387,fg=#313244,bold]{index} #[bg=#313244,fg=#cdd6f4,bold] {name}{fullscreen_indicator}#[bg=#45475a,fg=#313244,bold]█"
                tab_active_sync         "#[bg=#45475a,fg=#fab387]█#[bg=#fab387,fg=#313244,bold]{index} #[bg=#313244,fg=#cdd6f4,bold] {name}{sync_indicator}#[bg=#45475a,fg=#313244,bold]█"

                // separator between the tabs
                tab_separator           "#[bg=#1e1e2e] "

                // indicators
                tab_sync_indicator       " "
                tab_fullscreen_indicator " 󰊓"
                tab_floating_indicator   " 󰹙"

                command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
                command_git_branch_format      "#[fg=blue] {stdout} "
                command_git_branch_interval    "10"
                command_git_branch_rendermode  "static"

                datetime        "#[fg=#6C7086,bold] {format} "
                datetime_format "%A, %d %b %Y %H:%M"
                datetime_timezone "Europe/London"
            }
        }
        children
    }
}
    '';

    programs.zellij = {
      enable = true;
      # package = zellij-wrapped;
      # settings = {
      #   default_mode = "normal";
      #   default_shell = "fish";
      #   simplified_ui = true;
      #   pane_frames = false;
      #   theme = "catppuccin-mocha";
      #   copy_on_select = true;
      # };
    };
}
