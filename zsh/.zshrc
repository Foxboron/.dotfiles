ZSH=$HOME/.oh-my-zsh

plugins=(gitfastgit-extra
         archlinux 
         history-substring-search
         lein mosh systemd
         tmux virtualenv virtualenvwrapper
         colorize command-not-found)


source $ZSH/oh-my-zsh.sh
source /usr/bin/virtualenvwrapper.sh

stty ixany 
stty ixoff -ixon

#VIM Mode
bindkey -v
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey '^K' history-substring-search-up
bindkey '^J' history-substring-search-down

bindkey -M vicmd '^E' end-of-line
bindkey -M vicmd '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^A' beginning-of-line
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

PROMPT='%{$fg_bold[red]%}λ %n@%m %{$fg[green]%}%c %{$fg_bold[red]%}» $(git_prompt_info)%{$reset_color%}'

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[red]%} [% %{$fg_bold[green]%}NORMAL%{$fg_bold[red]%}]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}$EPS1"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1


ZSH_THEME_GIT_PROMPT_PREFIX="λ %{$fg[blue]%}git %{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[red]%} → %{$reset_color%}"

#export PYTHONPATH=/usr/lib/python3.3/site-packages



##ALIAS

alias tmux="tmux -2"
alias lock='dm-tool switch-to-greeter'
alias catp="pygmentize -g"
alias vimrc="vim ~/.vimrc"
alias zshrc="vim ~/.zshrc"
alias psg="ps aux | grep "
alias G="| grep "
alias L="| less "


function git-fixup {
  if [ $# -eq 1 ]
  then
    if [[ "$1" == HEAD* ]]
    then
      git add -A; git fixup $1; git ri $1~2
    else
      git add -A; git fixup $1; git ri $1~1
    fi
  else
    echo "Usage: gf <commit-ref> "
  fi
}


# Aliases / functions leveraging the cb() function
# ------------------------------------------------
# Copy contents of a file


publish () {
    if [ $# -eq 1 ]
    then
        cp -rR $1 ~/btsync/pub/pub
        cb "http://pub.velox.pw/pub/$1"
    else
        cp -rR $1 ~/btsync/pub/pub/$2
        cb "http://pub.velox.pw/pub/$2"
   fi
}


pretty_git_log() {
    git log --graph --pretty="tformat:${FORMAT}" $* |
        # Replace (2 years ago) with (2 years)
        sed -Ee 's/(^[^<]*) ago\)/\1)/' |
        # Replace (2 years, 5 months) with (2 years)
        sed -Ee 's/(^[^<]*), [[:digit:]]+ .*months?\)/\1)/' |
        # Line columns up based on } delimiter
        column -s '}' -t |
        # Color merge commits specially
        sed -Ee "s/(Merge (branch|remote-tracking branch|pull request) .*$)/$(printf $ANSI_RED)\1$(printf $ANSI_RESET)/" |
        # Page only if we're asked to.
        if [ -n "$GIT_NO_PAGER" ]; then
            cat
        else
            # Page only if needed.
            less --quit-if-one-screen --no-init --RAW-CONTROL-CHARS --chop-long-lines
        fi
}

vimx () {
    urxvt \
-foreground rgb:98/d1/ce \
-background rgb:0a/0f/14 \
-cursorColor rgb:98/d1/ce \
-color0 rgb:0a/0f/14 \
-color8 rgb:10/15/1b \
-color1 rgb:c3/30/27 \
-color9 rgb:d2/69/39 \
-color2 rgb:26/a9/8b \
-color10 rgb:08/1f/2d \
-color3 rgb:ed/b5/4b \
-color11 rgb:24/53/61 \
-color4 rgb:19/54/65 \
-color12 rgb:09/37/48 \
-color5 rgb:4e/51/65 \
-color13 rgb:88/8b/a5 \
-color6 rgb:33/85/9d \
-color14 rgb:59/9c/aa \
-color7 rgb:98/d1/ce \
-color15 rgb:d3/eb/e9 \
        -e zsh -i -c "vim $#" 2> /dev/null &
}
