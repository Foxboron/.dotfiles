DEBIAN_PREVENT_KEYBOARD_CHANGES=yes
#skip_global_compinit=1
export PATH="$HOME/bin:$HOME/.go/bin:$PATH"
export TERM="xterm-256color"

export VIRTUALENVWRAPPER_PYTHON="/usr/bin/python"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket" 
export LC_ALL=en_US.utf8
export LANG=en_US.utf8
export EDITOR="vim"
#PRIMUS
export PRIMUS_SYNC=0
export TERMINAL=termite
export BROWSER=/home/fox/bin/open.sh
export LEIN_JAVA_CMD=drip
export GOPATH="/home/fox/.go"
export WORKON_HOME="~/.cache/virtualenvs"
#export DOCKER_HOST=tcp://trinity.velox.pw:54321 DOCKER_TLS_VERIFY=1
export GO15VENDOREXPERIMENT=1
export FZF_DEFAULT_COMMAND='ag --hidden --follow --nogroup -g ""'
export FZF_DEFAULT_OPTS='--color 16'
export HISTSIZE=1000000
export SAVEHIST=1000000
export HISTFILE=~/.zsh_history
. /etc/profile.d/vte.sh
