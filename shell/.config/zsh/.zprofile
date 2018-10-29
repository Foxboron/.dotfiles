export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export TASKDATA="$XDG_DATA_HOME"/task
export TASKRC="$XDG_CONFIG_HOME"/task/taskrc
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"

# XDG Patches
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export VIMINIT=":source $XDG_CONFIG_HOME"/vim/vimrc
export LESSHISTFILE="$XDG_CACHE_HOME/lesshst"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"

export LC_ALL=en_US.utf8
export LANG=en_US.utf8
export PATH="$HOME/bin:$HOME/.go/bin:$PATH"
export TERM="xterm-256color"
export EDITOR="vim"
export TERMINAL=termite
export BROWSER=/home/fox/bin/open.sh
export GOPATH="/home/fox/.go"
export GPG_TTY=$(tty)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*"'

eval $(ssh-agent)
export GPG_AGENT_INFO SSH_AUTH_SOCK

if [[ -z $DISPLAY && $(tty) == /dev/tty1 ]]; then
    exec startx
fi
