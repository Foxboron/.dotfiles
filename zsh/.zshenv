DEBIAN_PREVENT_KEYBOARD_CHANGES=yes
skip_global_compinit=1
export PATH="$HOME/bin:$PATH"
case "$HOST" in
    hackbook) 
        export TERM="rxvt-unicode-256color";;
    debian)
        export TERM="screen-256color";;
    *)
        export TERM="rxvt-unicode-256color";;
esac

export VIRTUALENVWRAPPER_PYTHON="/usr/bin/python"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket" 
export LC_ALL=en_US.utf8
export LANG=en_US.utf8
export EDITOR="nvim"
#PRIMUS
export PRIMUS_SYNC=0
export vblank_mode=0
export TERMINAL=urxvt
export LEIN_JAVA_CMD=drip
