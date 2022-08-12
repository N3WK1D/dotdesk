#
# ~/.bash_logout
#

if [[ ! -z "${SSH_AUTH_SOCK}" ]]; then
    killall ssh-agent
fi
