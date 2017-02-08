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
  mkdir -p ~/.config/zsh/
  curl -fLo ~/.config/zsh/zplug/zplug --create-dirs https://git.io/zplug
  source ~/.config/zsh/zplug/zplug && zplug update --self
}


autoload -U promptinit && promptinit
autoload -U colors && colors
autoload -U compinit
ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
compinit -i -d "${ZSH_COMPDUMP}"

autoload -U run-help
autoload run-help-git
autoload run-help-svn
autoload run-help-svk
export HELPDIR=~/.config/zsh/zsh_help
bindkey '^P' run-help


# Source 
source ~/.config/zsh/zplug/init.zsh
#source /usr/bin/virtualenvwrapper.sh
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Zplug
zplug "zsh-users/zsh-completions"
zplug "plugins/gitgastgit-extra", from:oh-my-zsh
zplug "plugins/virtualenv", from:oh-my-zsh
zplug "plugins/virtualenvwrapper", from:oh-my-zsh
zplug "lib/completion", from:oh-my-zsh, ignore:oh-my-zsh.sh, defer:10
zplug "lib/directories", from:oh-my-zsh, ignore:oh-my-zsh.sh, defer:10
zplug "lib/git", from:oh-my-zsh, ignore:oh-my-zsh.sh, defer:10
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

zle -N edit-command-line
autoload -Uz edit-command-line
bindkey -M vicmd 'v' edit-command-line


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
alias tmuxconf="vim ~/.tmux.conf"
alias zshrc="vim ~/.zshrc && source ~/.zshrc"
alias i3conf="vim ~/.config/i3/config"
alias psg="ps aux | grep "
alias G="| grep "
alias L="| less "
alias g="grep -oEi"
alias ls="ls --color=tty"
alias xselix="xsel | ix"
alias ..="cd .."
alias yaourt="echo \"pacaur you idiot\""

# I really like having my files with find.
# There should be a better way to do this :/
function vimrc(){
    readonly CURRENTPATH=`pwd`
    cd ~/.vim
    vim ~/.vimrc
    cd $CURRENTPATH
}

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

# Source https://github.com/jelly/Dotfiles/blob/master/.zshrc#L307
# Start the gpg-agent if not already running
if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
  gpg-connect-agent /bye >/dev/null 2>&1
fi

# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
fi

# Set GPG TTY
GPG_TTY=$(tty)
export GPG_TTY

# Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null
