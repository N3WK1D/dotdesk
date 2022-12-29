#
# ~/.bash_profile
#

# Set umask
umask 027

# Set bash options
export HISTFILESIZE=0
export HISTCONTROL="ignoreboth"

# Set PATH variable
export PATH="${PATH}:${HOME}/.local/bin"

# Set EDITOR variable
export EDITOR="nvim"

# Set XDG_BASE_DIRS variables
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_DIRS="${XDG_DATA_HOME}:/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="${XDG_CONFIG_HOME}:/etc/xdg"

# Source ~/.bashrc if found
[[ -f ~/.bashrc ]] && source ~/.bashrc

# Start ssh-agent
[[ -z "$SSH_AUTH_SOCK" ]] && eval $(ssh-agent -s) &> /dev/null

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
