[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
syndaemon -t -k -i 2 -d &
xbindkeys
setxkbmap -option 'ctrl:nocaps' no
pulseaudio --start &
pasystray &
nm-applet &
dropboxd &
synergyc archserver
exec awesome
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
