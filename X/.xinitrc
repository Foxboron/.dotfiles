[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
xbindkeys
setxkbmap -layout us -variant altgr-intl -option 'ctrl:nocaps'
udiskie & 
tlp start &
unclutter -idle 4 & 
xset -dpms; xset s off 
synclient RightButtonAreaTop=2000
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
eval $(ssh-agent)
#compton -b
export GPG_AGENT_INFO SSH_AUTH_SOCK
exec i3
