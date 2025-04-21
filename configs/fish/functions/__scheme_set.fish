function __scheme_set \
  -d 'Set current color scheme to specified one' \
  -a scheme_name

  if [ -z $scheme_name ]
    echo (set_color normal)(set_color $fish_color_error)(set_color -o)'Error:'(set_color normal)' '(set_color $fish_color_normal)'Scheme name not provided.'(set_color normal)
    return 1
  end

  __scheme_get_definition "$scheme_name"

  set -xg fish_color_normal             $scheme_color_normal
  set -xg fish_color_command            $scheme_color_command
  set -xg fish_color_quote              $scheme_color_quote
  set -xg fish_color_redirection        $scheme_color_redirection
  set -xg fish_color_end                $scheme_color_end
  set -xg fish_color_error              $scheme_color_error
  set -xg fish_color_param              $scheme_color_param
  set -xg fish_color_comment            $scheme_color_comment
  set -xg fish_color_operator           $scheme_color_operator
  set -xg fish_color_escape             $scheme_color_escape
  set -xg fish_color_cwd                $scheme_color_cwd
  set -xg fish_color_cwd_root           $scheme_color_cwd_root
  set -xg fish_color_autosuggestion     $scheme_color_autosuggestion
  set -xg fish_color_user               $scheme_color_user
  set -xg fish_color_host               $scheme_color_host
  set -xg fish_color_cancel             $scheme_color_cancel
  set -xg fish_color_valid_path         $scheme_color_valid_path
  set -xg fish_color_match              $scheme_color_match
  set -xg fish_color_selection          $scheme_color_selection
  set -xg fish_color_search_match       $scheme_color_search_match
  set -xg fish_pager_color_prefix       $scheme_pager_color_prefix
  set -xg fish_pager_color_completion   $scheme_pager_color_completion
  set -xg fish_pager_color_description  $scheme_pager_color_description
  set -xg fish_pager_color_progress     $scheme_pager_color_progress
  set -xg fish_pager_color_secondary    $scheme_pager_color_secondary
  set -xg fish_color_history_current    $scheme_color_history_current

end
