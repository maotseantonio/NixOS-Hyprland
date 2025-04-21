function __scheme_preview_prompt
  # user@host ~/foo>
  # user, normal, host, cwd, normal
  set_color normal
  set_color $scheme_color_user
  echo -n 'user'
  set_color normal
  set_color $scheme_color_normal
  echo -n '@'
  set_color normal
  set_color $scheme_color_host
  echo -n 'host'
  set_color normal
  echo -n ' '
  set_color normal
  set_color $scheme_color_cwd
  echo -n '~/foo'
  set_color normal
  set_color $scheme_color_normal
  echo -n '> '
end


function __scheme_preview \
  -d 'Preview color scheme' \
  -a scheme_name

  # If no scheme specified, preview current scheme
  if [ -z $scheme_name ]
    set scheme_color_normal             $fish_color_normal
    set scheme_color_command            $fish_color_command
    set scheme_color_quote              $fish_color_quote
    set scheme_color_redirection        $fish_color_redirection
    set scheme_color_end                $fish_color_end
    set scheme_color_error              $fish_color_error
    set scheme_color_param              $fish_color_param
    set scheme_color_comment            $fish_color_comment
    set scheme_color_operator           $fish_color_operator
    set scheme_color_escape             $fish_color_escape
    set scheme_color_cwd                $fish_color_cwd
    set scheme_color_cwd_root           $fish_color_cwd_root
    set scheme_color_autosuggestion     $fish_color_autosuggestion
    set scheme_color_user               $fish_color_user
    set scheme_color_host               $fish_color_host
    set scheme_color_cancel             $fish_color_cancel
    set scheme_color_valid_path         $fish_color_valid_path
    set scheme_color_match              $fish_color_match
    set scheme_color_selection          $fish_color_selection
    set scheme_color_search_match       $fish_color_search_match
    set scheme_pager_color_prefix       $fish_pager_color_prefix
    set scheme_pager_color_completion   $fish_pager_color_completion
    set scheme_pager_color_description  $fish_pager_color_description
    set scheme_pager_color_progress     $fish_pager_color_progress
    set scheme_pager_color_secondary    $fish_pager_color_secondary
    set scheme_color_history_current    $fish_color_history_current
  else
    __scheme_get_definition "$scheme_name"
      or return $status
  end


  # # This is a preview of `$scheme_name` scheme.
  __scheme_preview_prompt
  set_color normal
  set_color $scheme_color_comment
  if [ -z $scheme_name ]
    echo '# This is a preview of the current color scheme'
  else
    echo "# This is a preview of the color scheme: $scheme_name"
  end


  # echo foo\nbar > /tmp/baz &
  # command, param, quote, redirection, end
  __scheme_preview_prompt
  set_color normal
  set_color $scheme_color_command
  echo -n 'echo'
  set_color normal
  echo -n ' '
  set_color normal
  set_color $scheme_color_param
  echo -n 'foo'
  set_color normal
  set_color $scheme_color_escape
  echo -n '\\n'
  set_color normal
  set_color $scheme_color_param
  echo -n 'bar'
  set_color normal
  echo -n ' '
  set_color normal
  set_color $scheme_color_redirection
  echo -n '>'
  set_color normal
  echo -n ' '
  set_color normal
  set_color $scheme_color_redirection
  echo -n '/tmp/baz'
  set_color normal
  echo -n ' '
  set_color normal
  set_color $scheme_color_end
  echo '&'


  # echo (cat /tmp/baz) | grep 'foo'
  # command, operator, command, param&valid_path, operator, end, command, quote
  __scheme_preview_prompt
  set_color normal
  set_color $scheme_color_command
  echo -n 'echo'
  set_color normal
  echo -n ' '
  set_color normal
  set_color $scheme_color_operator
  echo -n '('
  set_color normal
  set_color $scheme_color_command
  echo -n 'cat'
  set_color normal
  echo -n ' '
  set_color normal
  set_color $scheme_color_param
  set_color $scheme_color_valid_path
  echo -n '/tmp/baz'
  set_color normal
  set_color $scheme_color_operator
  echo -n ')'
  set_color normal
  echo -n ' '
  set_color normal
  set_color $scheme_color_end
  echo -n '|'
  set_color normal
  echo -n ' '
  set_color normal
  set_color $scheme_color_command
  echo -n 'grep'
  set_color normal
  echo -n ' '
  set_color normal
  set_color $scheme_color_quote
  echo '\'foo\''


  # echo 'Error: invalid stri^C
  # command, error, normal&cancel
  __scheme_preview_prompt
  set_color normal
  set_color $scheme_color_command
  echo -n 'echo'
  set_color normal
  echo -n ' '
  set_color normal
  set_color $scheme_color_error
  echo -n '\'Error: invalid stri'
  set_color normal
  set_color $scheme_color_cancel
  echo '^C'


  # This an autosuggestion
  # command, normal&-r, autosuggestion
  __scheme_preview_prompt
  set_color normal
  set_color $scheme_color_command
  echo -n 'Th'
  set_color normal
  set_color -r
  echo -n 'i'
  set_color normal
  set_color $scheme_color_autosuggestion
  echo 's an autosuggestion'

end
