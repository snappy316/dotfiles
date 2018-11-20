# Set Atom to default editor
set -gx EDITOR 'atom -wait'

# Make RBENV work
set -gx RBENV_ROOT /usr/local/var/rbenv
. (rbenv init -|psub)

# Make VSCode work - https://gist.github.com/rtorr/233bf6ffd81b6ecdf534
function code
  set location "$PWD/$argv"
  open -n -b "com.microsoft.VSCode" --args $location
end
set -g fish_user_paths "/usr/local/opt/postgresql@9.6/bin" $fish_user_paths
