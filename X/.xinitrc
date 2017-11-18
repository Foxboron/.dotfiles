[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
xbindkeys
#setxkbmap -layout us -variant altgr-intl -option 'ctrl:nocaps'
udiskie & 
unclutter -idle 4 & 
xset -dpms; xset s off 
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
eval $(ssh-agent)
compton -b
export GPG_AGENT_INFO SSH_AUTH_SOCK
export BROWSER=/home/fox/bin/open.sh
export GPG_TTY=$(tty)
exec i3
