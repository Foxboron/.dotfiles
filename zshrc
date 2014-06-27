ZSH=$HOME/.oh-my-zsh

plugins=(git archlinux 
         lein mosh 
         tmux virtualenv virtualenvwrapper
         colorize command-not-found 
         history-substring-search)

export PATH=$PATH:/home/fox/.gem/ruby/2.1.0/bin:$HOME/bin

source $ZSH/oh-my-zsh.sh
source /usr/bin/virtualenvwrapper.sh

export LC_ALL=en_US.utf8
export LANG=en_US.utf8
export EDITOR="vim"
export TERM="rxvt-unicode-256color"
export RANGER_LOAD_DEFAULT_RC="FALSE"
export GOPATH="/home/fox/.go/"
#PRIMUS
export PRIMUS_SYNC=0
export vblank_mode=0


#VIM Mode
bindkey -v
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey -M vicmd '^E' end-of-line
bindkey -M vicmd '^A' beginning-of-line


PROMPT='%{$fg_bold[red]%}λ %n@%m %{$fg[green]%}%c %{$fg_bold[red]%}» $(git_prompt_info)%{$reset_color%}'


ZSH_THEME_GIT_PROMPT_PREFIX="λ %{$fg[blue]%}git %{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[red]%} → %{$reset_color%}"

export PYTHONPATH=/usr/lib/python3.3/site-packages



##ALIAS

alias sshirc="mosh fox@146.185.137.105"
alias sshzerda="mosh fox@192.168.1.55"
alias sshvulpes="mosh fox@192.168.1.57"
alias tmux="tmux -2"


alias music="ncmpcpp"
alias viz='mpdviz -i --viz="wave" --imode="256" --icolor="true"'
alias gvimw="vim -g --servername GVIM"
alias screen-one='xrandr --output VGA1 --off'
alias screen-two='xrandr --output VGA1 --primary --auto'
alias vpn-connect='sudo systemctl start openvpn@SE-openvpn.service'
alias lock='dm-tool switch-to-greeter'
alias locknosuspend="sed 's/HandleLidSwitch=suspend/HandleLidSwitch=ignore/g' /etc/systemd/logind.conf | sudo tee /etc/systemd/logind.conf && sudo systemctl restart systemd-logind" 
alias locksuspend="sed 's/HandleLidSwitch=ignore/HandleLidSwitch=suspend/g' /etc/systemd/logind.conf | sudo tee /etc/systemd/logind.conf && sudo systemctl restart systemd-logind" 




gvim (){
    if [ $# -eq 0 ]
    then
        gvimw
    else
        gvimw --remote-tab $1
    fi
}

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

btscrot () {
    scrot -s "$1.png" -e "mv $1.png ~/btsync/pub/pub"
    cb "http://pub.velox.pw/pub/$1.png"
}



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




function extract()
{
     if [ -f $1 ] ; then
         case $1 in
            *.tar.bz2)   
                tar xvjf $1     
                ;;
            *.tar.gz)    
                tar xvzf $1     
                ;;
            *.bz2)       
                bunzip2 $1      
                ;;
            *.rar)
                unrar x $1      
                ;;
            *.gz)
                gunzip $1       
                ;;
            *.tar)
                tar xvf $1      
                ;;
            *.tbz2)
                tar xvjf $1     
                ;;
            *.tgz)
                tar xvzf $1     
                ;;
            *.zip)
                unzip $1        
                ;;
            *.Z)
                uncompress $1   
                ;;
            *.7z)
                7z x $1         
                ;;
            *)  
                echo "'$1' cannot be extracted via extract" 
                ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
