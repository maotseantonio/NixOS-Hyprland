function __scheme_print_usage
  echo (set_color normal)(set_color $fish_color_normal)(set_color -o)'Usage:'(set_color normal)
  echo '   '(set_color $fish_color_command)'scheme'(set_color normal)' '(set_color $fish_color_param)(set_color -o)'list'(set_color normal)(set_color $fish_color_normal)','(set_color normal)' '(set_color $fish_color_param)(set_color -o)'ls'(set_color normal)
  echo '       '(set_color $fish_color_normal)'List available color schemes.'(set_color normal)
  echo '   '(set_color $fish_color_command)'scheme'(set_color normal)' '(set_color $fish_color_param)(set_color -o)'preview'(set_color normal)' '(set_color normal)(set_color $fish_color_normal)'['(set_color normal)(set_color $fish_color_param)(set_color -u)'scheme-name'(set_color normal)(set_color $fish_color_normal)']'(set_color normal)
  echo '       '(set_color $fish_color_normal)'Preview the color scheme of '(set_color normal)(set_color $fish_color_param)(set_color -u)'scheme-name'(set_color normal)(set_color $fish_color_normal)'.'(set_color normal)
  echo '       '(set_color $fish_color_normal)'If '(set_color normal)(set_color $fish_color_param)(set_color -u)'scheme-name'(set_color normal)(set_color $fish_color_normal)' is empty, preview the current scheme.'(set_color normal)
  echo '   '(set_color $fish_color_command)'scheme'(set_color normal)' '(set_color $fish_color_param)(set_color -o)'set'(set_color normal)' '(set_color normal)(set_color $fish_color_param)(set_color -u)'scheme-name'(set_color normal)
  echo '       '(set_color $fish_color_normal)'Set color scheme to '(set_color normal)(set_color $fish_color_param)(set_color -u)'scheme-name'(set_color normal)(set_color $fish_color_normal)'.'(set_color normal)
end


function scheme \
  -d 'Configure fish\'s color scheme' \
  -a subcommand scheme_name

  if [ -z $subcommand ]
    __scheme_print_usage
    return 1
  else if [ $subcommand = 'list' ]; or [ $subcommand = 'ls' ]
    __scheme_list
  else if [ $subcommand = 'preview' ]
    __scheme_preview $scheme_name
  else if [ $subcommand = 'set' ]
    __scheme_set $scheme_name
      or return $status
  else
    echo (set_color normal)(set_color $fish_color_error)(set_color -o)'Error:'(set_color normal)' '(set_color $fish_color_normal)'Unknown command:'(set_color normal)' '(set_color $fish_color_error)$subcommand(set_color normal)
    __scheme_print_usage
    return 1
  end

end
