function __scheme_reset_to_default
  # Color values from: https://github.com/fish-shell/fish-shell/blob/82052a6cc9fa797070d8945130d45226d5cbc1c5/share/functions/__fish_config_interactive.fish#L51
  # normal
  set -g scheme_color_normal normal
  # commands
  set -g scheme_color_command 005fd7
  # quoted blocks of text
  set -g scheme_color_quote 999900
  # IO redirections
  set -g scheme_color_redirection 00afff
  # process separators like ';' and '&'
  set -g scheme_color_end 009900
  # potential errors
  set -g scheme_color_error ff0000
  # regular command parameters
  set -g scheme_color_param 00afff
  # code comments
  set -g scheme_color_comment 990000
  # parameter expansion operators like '*' and '~'
  set -g scheme_color_operator 00a6b2
  # character escapes like '\n' and '\x70'
  set -g scheme_color_escape 00a6b2
  # current working directory in the prompt
  set -g scheme_color_cwd green
  # current working directory in the prompt when superuser
  set -g scheme_color_cwd_root red
  # autosuggestions
  set -g scheme_color_autosuggestion 555
  # current username in the prompt
  set -g scheme_color_user brgreen
  # current host system in the prompt
  set -g scheme_color_host normal
  # '^C' indicator on a canceled command
  set -g scheme_color_cancel --reverse
  # valid path name
  set -g scheme_color_valid_path --underline
  # matching parenthesis
  set -g scheme_color_match --background=brblue
  # selected text (in vi visual mode)
  set -g scheme_color_selection white --bold --background=brblack
  # history search matches and the selected pager item (must be a background)
  set -g scheme_color_search_match bryellow --background=brblack
  # Additional for completion pager:
  # prefix string, i.e. the string that is to be completed
  set -g scheme_pager_color_prefix white --bold --underline
  # completion itself
  set -g scheme_pager_color_completion normal
  # completion description
  set -g scheme_pager_color_description B3A06D
  # progress bar at the bottom left corner
  set -g scheme_pager_color_progress brwhite --background=cyan
  # background color of the every second completion
  set -g scheme_pager_color_secondary
  # Additional for some commands:
  # current position out of `cdh` / `dirh` command
  set -g scheme_color_history_current --bold
end


function __scheme_get_definition \
  -d 'Get specified color scheme definition' \
  -a scheme_name

  # If no scheme specified, print available scheme list
  if [ -z $scheme_name ]
    echo 'catppuccin'
    echo 'default'
    echo 'dracula'
    echo 'monokai'
    echo 'solarized'
    echo 'tokyonight'
    echo 'tomorrow'
    echo 'tomorrow-night'
    echo 'tomorrow-night-bright'
    echo 'zenburn'
    return
  end

  switch $scheme_name

    case 'default'
      __scheme_reset_to_default

    # https://draculatheme.com
    case 'dracula'
      # Color palette
      set -l background     282a36
      set -l current_line   44475a
      set -l selection      44475a
      set -l foreground     f8f8f2
      set -l comment        6272a4
      set -l cyan           8be9fd
      set -l green          50fa7b
      set -l orange         ffb86c
      set -l pink           ff79c6
      set -l purple         bd93f9
      set -l red            ff5555
      set -l yellow         f1fa8c
      # Preferred to reset all colors
      __scheme_reset_to_default
      # Color configurations
      # set -g scheme_color_normal             normal
      set -g scheme_color_command            $foreground
      set -g scheme_color_quote              $yellow
      set -g scheme_color_redirection        $cyan
      set -g scheme_color_end                $green
      set -g scheme_color_error              $red
      set -g scheme_color_param              $pink
      set -g scheme_color_comment            $comment
      set -g scheme_color_operator           $green
      set -g scheme_color_escape             $purple
      set -g scheme_color_cwd                $green
      set -g scheme_color_cwd_root           $red
      set -g scheme_color_autosuggestion     $purple
      set -g scheme_color_user               $orange
      set -g scheme_color_host               $foreground
      # set -g scheme_color_cancel             --reverse
      # set -g scheme_color_valid_path         --underline
      # set -g scheme_color_match              --background=brblue
      # set -g scheme_color_selection          white --bold --background=brblack
      # set -g scheme_color_search_match       bryellow --background=brblack
      # set -g scheme_pager_color_prefix       white --bold --underline
      # set -g scheme_pager_color_completion   normal
      # set -g scheme_pager_color_description  B3A06D
      # set -g scheme_pager_color_progress     brwhite --background=cyan
      # set -g scheme_pager_color_secondary
      # set -g scheme_color_history_current    --bold

    case 'monokai'
      # Color palette
      set -l background     272822
      set -l foreground     d6d6d6
      set -l comment        75715e
      set -l cyan           66d9ef
      set -l green          a6e22e
      set -l orange         fd971f
      set -l purple         ae81ff
      set -l red            f92672
      set -l yellow         e6db74
      # Preferred to reset all colors
      __scheme_reset_to_default
      # Color configurations
      # set -g scheme_color_normal             normal
      set -g scheme_color_command            $cyan
      set -g scheme_color_quote              $yellow
      set -g scheme_color_redirection        $orange
      set -g scheme_color_end                $red
      set -g scheme_color_error              $red
      set -g scheme_color_param              $foreground
      set -g scheme_color_comment            $comment
      set -g scheme_color_operator           $foreground
      set -g scheme_color_escape             $purple
      set -g scheme_color_cwd                $green
      set -g scheme_color_cwd_root           $red
      set -g scheme_color_autosuggestion     $comment
      set -g scheme_color_user               $orange
      set -g scheme_color_host               $foreground
      # set -g scheme_color_cancel             --reverse
      # set -g scheme_color_valid_path         --underline
      # set -g scheme_color_match              --background=brblue
      # set -g scheme_color_selection          white --bold --background=brblack
      # set -g scheme_color_search_match       bryellow --background=brblack
      # set -g scheme_pager_color_prefix       white --bold --underline
      # set -g scheme_pager_color_completion   normal
      # set -g scheme_pager_color_description  B3A06D
      # set -g scheme_pager_color_progress     brwhite --background=cyan
      # set -g scheme_pager_color_secondary
      # set -g scheme_color_history_current    --bold

    # https://github.com/altercation/solarized
    case 'solarized'
      # Color palette
      set -l base03         002b36
      set -l base02         073642
      set -l base01         586e75
      set -l base00         657b83
      set -l base0          839496
      set -l base1          93a1a1
      set -l base2          eee8d5
      set -l base3          fdf6e3
      set -l yellow         b58900
      set -l orange         cb4b16
      set -l red            dc322f
      set -l magenta        d33682
      set -l violet         6c71c4
      set -l blue           268bd2
      set -l cyan           2aa198
      set -l green          859900
      # Preferred to reset all colors
      __scheme_reset_to_default
      # Color configurations
      # set -g scheme_color_normal             normal
      set -g scheme_color_command            $blue
      set -g scheme_color_quote              $cyan
      set -g scheme_color_redirection        $violet
      set -g scheme_color_end                $green
      set -g scheme_color_error              $red
      set -g scheme_color_param              $base1
      set -g scheme_color_comment            $base01
      set -g scheme_color_operator           $yellow
      set -g scheme_color_escape             $base00
      set -g scheme_color_cwd                $yellow
      set -g scheme_color_cwd_root           $red
      set -g scheme_color_autosuggestion     $base01
      set -g scheme_color_user               $magenta
      set -g scheme_color_host               $base1
      # set -g scheme_color_cancel             --reverse
      # set -g scheme_color_valid_path         --underline
      # set -g scheme_color_match              --background=brblue
      # set -g scheme_color_selection          white --bold --background=brblack
      # set -g scheme_color_search_match       bryellow --background=brblack
      # set -g scheme_pager_color_prefix       white --bold --underline
      # set -g scheme_pager_color_completion   normal
      # set -g scheme_pager_color_description  B3A06D
      # set -g scheme_pager_color_progress     brwhite --background=cyan
      # set -g scheme_pager_color_secondary
      # set -g scheme_color_history_current    --bold

    # https://github.com/chriskempson/tomorrow-theme
    case 'tomorrow'
      # Color palette
      set -l background     ffffff
      set -l current_line   efefef
      set -l selection      d6d6d6
      set -l foreground     4d4d4c
      set -l comment        8e908c
      set -l red            c82829
      set -l orange         f5871f
      set -l yellow         eab700
      set -l green          718c00
      set -l aqua           3e999f
      set -l blue           4271ae
      set -l purple         8959a8
      # Preferred to reset all colors
      __scheme_reset_to_default
      # Color configurations
      # set -g scheme_color_normal             normal
      set -g scheme_color_command            $purple
      set -g scheme_color_quote              $green
      set -g scheme_color_redirection        $aqua
      set -g scheme_color_end                $purple
      set -g scheme_color_error              $red
      set -g scheme_color_param              $blue
      set -g scheme_color_comment            $comment
      set -g scheme_color_operator           $orange
      set -g scheme_color_escape             $orange
      set -g scheme_color_cwd                $aqua
      set -g scheme_color_cwd_root           $red
      set -g scheme_color_autosuggestion     $comment
      set -g scheme_color_user               $green
      set -g scheme_color_host               $foreground
      # set -g scheme_color_cancel             --reverse
      # set -g scheme_color_valid_path         --underline
      # set -g scheme_color_match              --background=brblue
      # set -g scheme_color_selection          white --bold --background=brblack
      # set -g scheme_color_search_match       bryellow --background=brblack
      # set -g scheme_pager_color_prefix       white --bold --underline
      # set -g scheme_pager_color_completion   normal
      # set -g scheme_pager_color_description  B3A06D
      # set -g scheme_pager_color_progress     brwhite --background=cyan
      # set -g scheme_pager_color_secondary
      # set -g scheme_color_history_current    --bold

    # https://github.com/chriskempson/tomorrow-theme
    case 'tomorrow-night'
      # Color palette
      set -l background     1d1f21
      set -l current_line   282a2e
      set -l selection      373b41
      set -l foreground     c5c8c6
      set -l comment        969896
      set -l red            cc6666
      set -l orange         de935f
      set -l yellow         f0c674
      set -l green          b5bd68
      set -l aqua           8abeb7
      set -l blue           81a2be
      set -l purple         b294bb
      # Preferred to reset all colors
      __scheme_reset_to_default
      # Color configurations
      # set -g scheme_color_normal             normal
      set -g scheme_color_command            $purple
      set -g scheme_color_quote              $green
      set -g scheme_color_redirection        $aqua
      set -g scheme_color_end                $purple
      set -g scheme_color_error              $red
      set -g scheme_color_param              $blue
      set -g scheme_color_comment            $comment
      set -g scheme_color_operator           $orange
      set -g scheme_color_escape             $orange
      set -g scheme_color_cwd                $aqua
      set -g scheme_color_cwd_root           $red
      set -g scheme_color_autosuggestion     $comment
      set -g scheme_color_user               $green
      set -g scheme_color_host               $foreground
      # set -g scheme_color_cancel             --reverse
      # set -g scheme_color_valid_path         --underline
      # set -g scheme_color_match              --background=brblue
      # set -g scheme_color_selection          white --bold --background=brblack
      # set -g scheme_color_search_match       bryellow --background=brblack
      # set -g scheme_pager_color_prefix       white --bold --underline
      # set -g scheme_pager_color_completion   normal
      # set -g scheme_pager_color_description  B3A06D
      # set -g scheme_pager_color_progress     brwhite --background=cyan
      # set -g scheme_pager_color_secondary
      # set -g scheme_color_history_current    --bold

    # https://github.com/chriskempson/tomorrow-theme
    case 'tomorrow-night-bright'
      # Color palette
      set -l background     000000
      set -l current_line   2a2a2a
      set -l selection      424242
      set -l foreground     eaeaea
      set -l comment        969896
      set -l red            d54e53
      set -l orange         e78c45
      set -l yellow         e7c547
      set -l green          b9ca4a
      set -l aqua           70c0b1
      set -l blue           7aa6da
      set -l purple         c397d8
      # Preferred to reset all colors
      __scheme_reset_to_default
      # Color configurations
      # set -g scheme_color_normal             normal
      set -g scheme_color_command            $purple
      set -g scheme_color_quote              $green
      set -g scheme_color_redirection        $aqua
      set -g scheme_color_end                $purple
      set -g scheme_color_error              $red
      set -g scheme_color_param              $blue
      set -g scheme_color_comment            $comment
      set -g scheme_color_operator           $orange
      set -g scheme_color_escape             $orange
      set -g scheme_color_cwd                $aqua
      set -g scheme_color_cwd_root           $red
      set -g scheme_color_autosuggestion     $comment
      set -g scheme_color_user               $green
      set -g scheme_color_host               $foreground
      # set -g scheme_color_cancel             --reverse
      # set -g scheme_color_valid_path         --underline
      # set -g scheme_color_match              --background=brblue
      # set -g scheme_color_selection          white --bold --background=brblack
      # set -g scheme_color_search_match       bryellow --background=brblack
      # set -g scheme_pager_color_prefix       white --bold --underline
      # set -g scheme_pager_color_completion   normal
      # set -g scheme_pager_color_description  B3A06D
      # set -g scheme_pager_color_progress     brwhite --background=cyan
      # set -g scheme_pager_color_secondary
      # set -g scheme_color_history_current    --bold

    # https://github.com/jnurmine/Zenburn
    case 'zenburn'
      # Color palette
      set -l background     3f3f3f
      set -l foreground     dcdccc
      set -l cyan           9bced2
      set -l green          7f9f7f
      set -l pink           d191c0
      set -l red            cc9393
      set -l yellow         efef8f
      set -l orange         ffcfaf
      set -l cream          e3ceab
      set -l white          dfdfdf
      set -l gray           53606e
      # Preferred to reset all colors
      __scheme_reset_to_default
      # Color configurations
      # set -g scheme_color_normal             normal
      set -g scheme_color_command            $yellow
      set -g scheme_color_quote              $orange
      set -g scheme_color_redirection        $cyan
      set -g scheme_color_end                $pink
      set -g scheme_color_error              $red
      set -g scheme_color_param              $foreground
      set -g scheme_color_comment            $green
      set -g scheme_color_operator           $cream
      set -g scheme_color_escape             $orange
      set -g scheme_color_cwd                $orange
      set -g scheme_color_cwd_root           $red
      set -g scheme_color_autosuggestion     $gray
      set -g scheme_color_user               $cream
      set -g scheme_color_host               $foreground
      # set -g scheme_color_cancel             --reverse
      # set -g scheme_color_valid_path         --underline
      # set -g scheme_color_match              --background=brblue
      # set -g scheme_color_selection          white --bold --background=brblack
      # set -g scheme_color_search_match       bryellow --background=brblack
      # set -g scheme_pager_color_prefix       white --bold --underline
      # set -g scheme_pager_color_completion   normal
      # set -g scheme_pager_color_description  B3A06D
      # set -g scheme_pager_color_progress     brwhite --background=cyan
      # set -g scheme_pager_color_secondary
      # set -g scheme_color_history_current    --bold

    case 'tokyonight'
      # Color Palette
      set -l foreground c0caf5
      set -l selection 33467C
      set -l comment 565f89
      set -l red f7768e
      set -l orange ff9e64
      set -l yellow e0af68
      set -l green 9ece6a
      set -l purple 9d7cd8
      set -l cyan 7dcfff
      set -l pink bb9af7
      __scheme_reset_to_default
      # Syntax Highlighting Colors
      set -g scheme_color_normal $foreground
      set -g scheme_color_command $cyan
      set -g scheme_color_keyword $pink
      set -g scheme_color_quote $yellow
      set -g scheme_color_redirection $pink
      set -g scheme_color_end $orange
      set -g scheme_color_error $red
      set -g scheme_color_param $purple
      set -g scheme_color_comment $comment
      set -g scheme_color_selection --background=$selection
      set -g scheme_color_search_match --background=$selection
      set -g scheme_color_operator $green
      set -g scheme_color_escape $pink
      set -g fish_color_autosuggestion $comment
      # Completion Pager Colors
      set -g scheme_pager_color_progress $comment
      set -g scheme_pager_color_prefix $cyan
      set -g scheme_pager_color_completion $foreground
      set -g scheme_pager_color_description $comment

    # https://github.com/catppuccin/fish
    case 'catppuccin'
    #Color Palette
    set -l foreground dadae8
    set -l selection 3e4058
    set -l teal bee4ed
    set -l flamingo f2cecf
    set -l magenta c6aae8
    set -l pink e5b4e2
    set -l red e38c8f
    set -l peach f9c096
    set -l green b1e3ad
    set -l yellow ebddaa
    set -l blue a4b9ef
    set -l gray 6e6c7e
    __scheme_reset_to_default
    # Syntax Highlighting Colors
    set -g scheme_color_normal $foreground
    set -g scheme_color_command $blue
    set -g scheme_color_param $flamingo
    set -g scheme_color_keyword $red
    set -g scheme_color_quote $green
    set -g scheme_color_redirection $pink
    set -g scheme_color_end $peach
    set -g scheme_color_error $red
    set -g scheme_color_gray $gray
    set -g scheme_color_selection --background=$selection
    set -g scheme_color_search_match --background=$selection
    set -g scheme_color_operator $pink
    set -g scheme_color_escape $flamingo
    set -g scheme_color_autosuggestion $gray
    set -g scheme_color_cancel $red
    # Prompt
    set -g scheme_color_cwd $yellow
    set -g scheme_color_user $teal
    set -g scheme_color_host $blue
    # Completion Pager
    set -g scheme_pager_color_progress $gray
    set -g scheme_pager_color_prefix $pink
    set -g scheme_pager_color_completion $foreground
    set -g scheme_pager_color_description $gray

    case '*'
      echo (set_color normal)(set_color $fish_color_error)(set_color -o)'Error:'(set_color normal)' '(set_color $fish_color_normal)'No such scheme available:'(set_color normal)' '(set_color $fish_color_error)$scheme_name(set_color normal)
      return 1

  end

end
