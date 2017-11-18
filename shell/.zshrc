# {{{ 1 zplug
#{{{2 Init
[[ -d ~/.zplug ]] || {
  mkdir -p ~/.config/zsh/
  curl -fLo ~/.config/zsh/zplug/zplug --create-dirs https://git.io/zplug
  source ~/.config/zsh/zplug/zplug && zplug update --self
}
source ~/.config/zsh/zplug/init.zsh
# }}}
 zplug "zsh-users/zsh-completions"
 # zplug "plugins/gitgastgit-extra", from:oh-my-zsh
 # zplug "plugins/virtualenv", from:oh-my-zsh
# zplug "plugins/virtualenvwrapper", from:oh-my-zsh
# zplug "lib/completion", from:oh-my-zsh, ignore:oh-my-zsh.sh, defer:1
# zplug "lib/directories", from:oh-my-zsh, ignore:oh-my-zsh.sh, defer:1
# zplug "lib/git", from:oh-my-zsh, ignore:oh-my-zsh.sh, defer:1
 zplug "zsh-users/zsh-history-substring-search"
zplug load
# zplug install{{{
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi
# }}}
# }}}
# {{{ setopts
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY 
setopt sharehistory
setopt extendedhistory
setopt appendhistory 
setopt autocd 
setopt extendedglob 
setopt prompt_subst
# }}}
# autoload{{{
autoload -U promptinit && promptinit
autoload -U colors && colors
autoload -U compinit
ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
compinit -i -d "${ZSH_COMPDUMP}"

autoload -U run-help
autoload run-help-git
autoload run-help-svn
autoload run-help-svk
# }}}
# Export{{{
export HELPDIR=~/.config/zsh/zsh_help
export KEYTIMEOUT=1                     # For vim status line
# export PAGER=/usr/bin/vimpager
# }}}
# {{{ stty
stty ixany 
stty ixoff -ixon
# }}}
#{{{ Bindkey
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
bindkey '^P' run-help

zle -N edit-command-line
autoload -Uz edit-command-line
bindkey -M vicmd 'v' edit-command-line
# }}}
# Prompt{{{
function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[red]%} [% %{$fg_bold[green]%}NORMAL%{$fg_bold[red]%}]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}$EPS1"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select


ZSH_THEME_GIT_PROMPT_PREFIX="λ %{$fg[blue]%}git %{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[red]%} → %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='%{$fg_bold[red]%}λ %n@%m %{$fg[green]%}%c %{$fg_bold[red]%}» $(git_prompt_info)%{$reset_color%}'
# }}}
#Alias{{{
alias tmux="tmux -2"
alias tmuxconf="vim ~/.tmux.conf"
alias zshrc="vim ~/.zshrc && source ~/.zshrc"
alias i3conf="vim ~/.config/i3/config"
alias psg="ps aux | grep "
alias g="grep -oEi"
alias ls="ls --color=tty"
alias xselix="xsel | ix"
alias ..="cd .."
alias ls="exa"
alias l='ls -lF'
alias la='ls -laF'

alias -g G='| grep'
alias -g L='| less'
alias -g T='| tail'

# alias less=$PAGER
# alias zless=$PAGER

alias auracle='auracle --color=auto'
alias as='auracle search'
alias asy='auracle sync'
alias au='auracle download'
alias aud='auracle download -r *'
alias ab='auracle buildorder *'

# pacman alias
alias pacman='pacman --color auto'
alias pacupg='sudo pacman -Syu'
# }}}
# {{{ Functions
function vimrc(){
    vim ~/.vimrc -c "cd ~/.vim"
}
ss(){
    pacman -Ss $1
    as $1
}
# }}}
# zstyle{{{
unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
# }}}
# vim: fdm=marker
