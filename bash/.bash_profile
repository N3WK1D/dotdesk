#
# ~/.bash_profile
#

# Source ~/.bashrc if found
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Autostart
[[ ! -s ~/.mpd/pid ]] && mpd &
