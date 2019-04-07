# common aliases
alias vi="vim"
alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"

# git : go back to repository root
alias gr='pushd $(git rev-parse --show-toplevel)'
