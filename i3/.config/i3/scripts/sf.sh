#!/bin/bash

# Define colors
bc=$(tput bold)	    # bold
c0=$(tput setaf 0)  # black
c1=$(tput setaf 1)  # red
c2=$(tput setaf 2)  # green
c3=$(tput setaf 3)  # yellow
c4=$(tput setaf 4)  # blue
c5=$(tput setaf 5)  # magenta
c6=$(tput setaf 6)  # cyan
c7=$(tput setaf 7)  # white
rc=$(tput sgr0)	    # reset

lc=${c6}       # labels
tc=${c7}       # text
fc=${c3}       # first color
sc=${c6}       # second color
hc=${c5}       # highlight color


# Get info
#HOST=$(hostname)
OS=$(lsb_release -i | cut -d ":" -f 2 | tr -d "\t")
KERNEL=$(uname -sr)
UPTIME=$(uptime -p | sed s:"up "::)
PACKAGES=$(pacman -Q | wc -l)
RESOLUTION=$(xdpyinfo | sed -n 's/.*dim.* \([0-9]*x[0-9]*\) .*/\1/pg' | sed ':a;N;$!ba;s/\n/ /g')
SHLL=$(zsh --version)
WM=$(echo $GDMSESSION)

cat << EOF
[49m          [48;5;235m            [49m
      [48;5;235m    [48;5;231m    [48;5;124m    [48;5;231m    [48;5;235m    [49m
    [48;5;235m  [48;5;124m  [48;5;231m      [48;5;196m    [48;5;231m      [48;5;124m   [48;5;235m  [49m
  [48;5;235m  [48;5;124m  [48;5;196m  [48;5;231m    [48;5;196m        [48;5;231m    [48;5;196m  [48;5;124m  [48;5;235m  [49m
  [48;5;235m  [48;5;231m  [48;5;196m      [48;5;208m        [48;5;196m      [48;5;231m  [48;5;235m  [49m     
[48;5;235m  [48;5;231m      [48;5;196m  [48;5;208m  [48;5;231m        [48;5;208m  [48;5;196m  [48;5;231m      [48;5;235m  [49m    ${c1}OS:${rc} ${OS}
[48;5;235m  [48;5;231m      [48;5;196m  [48;5;231m            [48;5;196m  [48;5;231m      [48;5;235m  [49m    ${c1}KERNEL:${rc} ${KERNEL}
[48;5;235m  [48;5;231m      [48;5;196m  [48;5;231m            [48;5;196m  [48;5;231m      [48;5;235m  [49m    ${c1}UPTIME:${rc} ${UPTIME}
[48;5;235m  [48;5;231m    [48;5;196m    [48;5;231m            [48;5;196m    [48;5;231m    [48;5;235m  [49m    ${c1}PACKAGES:${rc} ${PACKAGES}
[48;5;235m  [48;5;124m  [48;5;196m  [48;5;124m      [48;5;231m        [48;5;124m      [48;5;196m  [48;5;124m  [48;5;235m  [49m    ${c1}SHELL:${rc}  ${SHLL}
[48;5;235m  [48;5;124m    [48;5;235m                    [48;5;124m    [48;5;235m  [49m    ${c1}WM:${rc}  ${WM}
  [48;5;235m      [48;5;216m    [48;5;235m  [48;5;216m    [48;5;235m  [48;5;216m    [48;5;235m      [49m      ${c1}RESOLUTION:${rc}  ${RESOLUTION}
    [48;5;235m  [48;5;216m  [48;5;231m    [48;5;235m  [48;5;231m    [48;5;235m  [48;5;231m    [48;5;216m  [48;5;235m  [49m
    [48;5;235m  [48;5;216m  [48;5;231m                [48;5;216m  [48;5;235m  [49m
      [48;5;235m  [48;5;216m                [48;5;235m  [49m
        [48;5;235m                [39;49m
EOF
COLS="$(xrdb -query| grep -Ei [.*]color[01-9] | sort -n -tr -k2 | tr -d [*[:blank:]])" 
for i in {0..7}; do echo -en "\e[0;3${i}m▉▉▉▉▉▉▉\t"; done; echo 
for i in {0..7}; do echo -en "\e[0;9${i}m▉▉▉▉▉▉▉\t"; done; echo
