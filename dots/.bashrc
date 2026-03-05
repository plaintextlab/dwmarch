#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias mtp='sudo umount -l /mnt/phone && jmtpfs /mnt/phone'

alias dwmc='cd ~/dwmarch/dwm && rm -f config.h && sudo make clean install && cd -'
alias dwmblocksc='cd ~/dwmarch/dwmblocks && rm -f blocks.h && sudo make clean install && cd -'
alias logout='pkill -KILL -u $USER'

if [[ -n "$DISPLAY" ]]; then
    eval "$(starship init bash)"
fi

# Created by `pipx` on 2026-03-05 09:07:03
export PATH="$PATH:/home/bita/.local/bin"
