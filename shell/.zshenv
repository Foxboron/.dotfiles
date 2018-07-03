export LC_ALL=en_US.utf8
export LANG=en_US.utf8
export PATH="$HOME/bin:$HOME/.go/bin:$PATH"
export TERM="xterm-256color"
export EDITOR="vim"
export TERMINAL=termite
export BROWSER=/home/fox/bin/open.sh
export GOPATH="/home/fox/.go"
export HISTSIZE=1000000
export SAVEHIST=1000000
export GPG_TTY=$(tty)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*"'
export HISTFILE=~/.local/share/zsh/history
export VIMINIT=":source ~/.config"/vim/vimrc
export ZDOTDIR=$HOME/.config/zsh
. /etc/profile.d/vte.sh
