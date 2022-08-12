#
# ~/.bash_profile
#

# Source ~/.bashrc if found
if [[ -f ~/.bashrc ]]; then
    source ~/.bashrc
fi

# Autostart X11 on tty1
if shopt -q login_shell; then
    if [[ -t 0 && "$(tty)" == "/dev/tty1" && ! $DISPLAY ]]; then
        if startx &> /dev/null; then
            exit
        else
            echo "The X session aborted! Dropped to text shell." >&2
        fi
    fi
else
    exit 1 # Somehow this is a non-bash or non-login shell
fi
