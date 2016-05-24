setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY 
setopt sharehistory
setopt extendedhistory
setopt appendhistory 
setopt autocd 
setopt extendedglob 
setopt prompt_subst

# Check if zplug is installed
[[ -d ~/.zplug ]] || {
  curl -fLo ~/.zplug/zplug --create-dirs https://git.io/zplug
  source ~/.zplug/zplug && zplug update --self
}


autoload -U promptinit && promptinit
autoload -U colors && colors
autoload -U compinit
ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
compinit -i -d "${ZSH_COMPDUMP}"



# Source 
source ~/.zplug/zplug
#source /usr/bin/virtualenvwrapper.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Zplug
zplug "zsh-users/zsh-completions"
zplug "plugins/gitgastgit-extra", from:oh-my-zsh
zplug "plugins/virtualenv", from:oh-my-zsh
zplug "plugins/virtualenvwrapper", from:oh-my-zsh
zplug "lib/completion", from:oh-my-zsh, ignore:oh-my-zsh.sh, nice:10
zplug "lib/directories", from:oh-my-zsh, ignore:oh-my-zsh.sh, nice:10
zplug "lib/git", from:oh-my-zsh, ignore:oh-my-zsh.sh, nice:10
zplug "zsh-users/zsh-history-substring-search"

zplug load


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

#prompt

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
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='%{$fg_bold[red]%}λ %n@%m %{$fg[green]%}%c %{$fg_bold[red]%}» $(git_prompt_info)%{$reset_color%}'


##ALIAS
alias tmux="tmux -2"
alias vim="nvim"
alias vimrc="vim ~/.config/nvim/init.vim"
alias zshrc="vim ~/.zshrc"
alias i3conf="vim ~/.config/i3/config"
alias psg="ps aux | grep "
alias G="| grep "
alias L="| less "
alias dc="docker-compose"
alias g="grep -oEi"
alias ls="ls --color=tty"
alias xselix="xsel | ix"
alias ..="cd .."
alias yaourt="echo \"pacaur you idiot\""


if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi
