[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
syndaemon -t -k -i 2 -d &
xbindkeys
nm-applet &
sleep 10 && dropboxd &
exec awesome
