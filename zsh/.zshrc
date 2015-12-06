ZSH=$HOME/.oh-my-zsh

plugins=(gitfastgit-extra
         archlinux 
         history-substring-search
         systemd
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
alias vim="nvim"
alias catp="pygmentize -g"
alias vimrc="vim ~/.config/nvim/init.vim"
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

