ZSH=$HOME/.oh-my-zsh

plugins=(git archlinux git-extras gitfast git-flow github git-hubflow lein mosh pip ssh-agent sublime tmux tmuxinator virtualenv virtualenvwrapper)

source $ZSH/oh-my-zsh.sh
source /usr/bin/virtualenvwrapper.sh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR="vim"
export PROJET_HOME="~/Dropbox/Python"


#PRIMUS
export PRIMUS_SYNC=0
export vblank_mode=0


PROMPT='%{$fg_bold[cyan]%}λ %n@%m %{$fg[green]%}%c %{$fg_bold[cyan]%}→ $(git_prompt_info)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="λ %{$fg[blue]%}git %{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[cyan]%} → %{$reset_color%}"

export PYTHONPATH=/usr/lib/python3.3/site-packages



##ALIAS

alias sshirc="mosh fox@146.185.137.105"
alias tmux="tmux -2"

alias music="ncmpcpp"

alias yaoupg='yaourt -Syu'

alias pacupg='sudo pacman -Syu'        # Synchronize with repositories and then upgrade packages that are out of date on the local system.
alias pacin='sudo pacman -S'           # Install specific package(s) from the repositories
alias pacins='sudo pacman -U'          # Install specific package not from the repositories but from a file 
alias pacre='sudo pacman -R'           # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem='sudo pacman -Rns'        # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacrep='pacman -Si'              # Display information about a given package in the repositories
alias pacreps='pacman -Ss'             # Search for package(s) in the repositories
alias pacloc='pacman -Qi'              # Display information about a given package in the local databas
alias paclocs='pacman -Qs'             # Search for package(s) in the local database
alias pacupd='sudo pacman -Sy && sudo abs'     # Update and refresh the local package and ABS databases against repositories
alias pacinsd='sudo pacman -S --asdeps'        # Install given package(s) as dependencies of another package
alias pacmir='sudo pacman -Syy'                # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist





cb() {
  local _scs_col="\e[0;32m"; local _wrn_col='\e[1;31m'; local _trn_col='\e[0;33m'
  # Check that xclip is installed.
  if ! type xclip > /dev/null 2>&1; then
    echo -e "$_wrn_col""You must have the 'xclip' program installed.\e[0m"
  # Check user is not root (root doesn't have access to user xorg server)
  elif [[ "$USER" == "root" ]]; then
    echo -e "$_wrn_col""Must be regular user (not root) to copy a file to the clipboard.\e[0m"
  else
    # If no tty, data should be available on stdin
    if ! [[ "$( tty )" == /dev/* ]]; then
      input="$(< /dev/stdin)"
    # Else, fetch input from params
    else
      input="$*"
    fi
    if [ -z "$input" ]; then  # If no input, print usage message.
      echo "Copies a string to the clipboard."
      echo "Usage: cb <string>"
      echo "       echo <string> | cb"
    else
      # Copy input to clipboard
      echo -n "$input" | xclip -selection c
      # Truncate text for status
      if [ ${#input} -gt 80 ]; then input="$(echo $input | cut -c1-80)$_trn_col...\e[0m"; fi
      # Print status.
      echo -e "$_scs_col""Copied to clipboard:\e[0m $input"
    fi
  fi
}
# Aliases / functions leveraging the cb() function
# ------------------------------------------------
# Copy contents of a file
function cbf() { cat "$1" | cb; }  


scrotf () {
	scrot "$1.png" -e 'mv $f ~/Dropbox/Public/sslinux'
}


puburl () {
	dropbox puburl $1 | cb
}

cbprint () {
	dropbox puburl ~/Dropbox/Public/sslinux/$1.png | cb
}


db () {
	cd /home/fox/Dropbox/Public/sslinux
	file="$(ls -t | head -1)"
	puburl $file
}

scrotcb () {
	scrot "$1.png" -e 'mv $f ~/Dropbox/Public/sslinux'
	cbprint $1
}


