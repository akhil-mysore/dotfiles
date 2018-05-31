# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
if [ -f /home/akhil/dotfiles/.bashrc.arista ]; then
   . /home/akhil/dotfiles/.bashrc.arista
fi

# User specific aliases and functions # Akhil
alias vi="VIMRUNTIME=~/mlocal/share/vim/vim81 ~/mlocal/bin/vim"
alias l='ls -F'
alias ll='ls -ltrF'
alias la='ls -altrF'
alias ppid='ps -o ppid= -p'
alias vic='vim /tmp/temp.c'
alias vipy='vim /tmp/temp.py'
alias pt='pt --ignore tags '
alias f='find . -iname '
alias gitb='git branch'
alias tmux="TERM=screen-256color tmux"

export TERM=xterm-256color # screen-256color
# https://unix.stackexchange.com/questions/4859/
export VISUAL=vi
export EDITOR="$VISUAL"
#
export VIM="/usr/share/vim/"
export PATH="/home/akhil/bin/:$PATH"
export PYTHONPATH=$PYTHONPATH:/home/akhil/bin/

#!! https://stackoverflow.com/questions/19454837
unset HISTFILESIZE # unlimited history
HISTSIZE=100000
#
#!! https://unix.stackexchange.com/questions/18212
HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"
#
# Set vi binding
set -o vi

# https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

#stty -ixon
# export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
# export CLICOLOR=1
# Next line added by a4c-tmux window renaming system, delete to uninstall
#export PATH="/home/akhil/projects/a4c-tmux-window-naming:$PATH"
# Next line added by a4c-tmux window renaming system, delete to uninstall
#export TMUX_TMPDIR="$HOME/tmp"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
