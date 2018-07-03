if [[ -z $DISPLAY && $(tty) == /dev/tty1 ]]; then
    export VIMINIT=":source ~/config"/vim/vimrc
    exec startx
fi
