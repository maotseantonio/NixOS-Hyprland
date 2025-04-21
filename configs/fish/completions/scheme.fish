function __scheme_needs_subcommand
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 ]
    return 0
  end
  return 1
end

function __scheme_is_subcommand -a subcommand
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 2 ]; and [ $cmd[2] = $subcommand ]
    return 0
  end
  return 1
end

set -l scheme_list (scheme ls)

# Always don't comple paths
complete -f -c scheme

# Completions for `scheme ls`
complete -f -c scheme -n '__scheme_needs_subcommand' -a ls -d 'List available color schemes'

# Completions for `scheme preview`
complete -f -c scheme -n '__scheme_needs_subcommand' -a preview -d 'Preview the color scheme'
complete -f -c scheme -n '__scheme_is_subcommand preview' -a "$scheme_list"

# Completions for `scheme set`
complete -f -c scheme -n '__scheme_needs_subcommand' -a set -d 'Set color scheme'
complete -f -c scheme -n '__scheme_is_subcommand set' -a "$scheme_list"
