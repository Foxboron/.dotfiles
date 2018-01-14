[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
xbindkeys
udiskie & 
unclutter -idle 4 & 
xset -dpms; xset s off 
eval $(ssh-agent)
compton -b
export GPG_AGENT_INFO SSH_AUTH_SOCK
export BROWSER=/home/fox/bin/open.sh
export GPG_TTY=$(tty)
exec i3
