#
# ~/.bashrc
#

# Get current status of git repo
parse_git_status() {
declare status="$(git status 2>&1 | tee)"
declare dirty="$(echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?")"
declare untracked="$(echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?")"
declare ahead="$(echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?")"
declare newfile="$(echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?")"
declare renamed="$(echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?")"
declare deleted="$(echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?")"
declare bits=''
[[ "${deleted}" -eq 0 ]] && bits="-${bits}"
[[ "${renamed}" -eq 0 ]] && bits="*${bits}"
[[ "${newfile}" -eq 0 ]] && bits="+${bits}"
[[ "${ahead}" -eq 0 ]] && bits=">${bits}"
[[ "${untracked}" -eq 0 ]] && bits="?${bits}"
[[ "${dirty}" -eq 0 ]] && bits="!${bits}"
[[ -n "${bits}" ]] && echo -n " ${bits}" || echo -n ""
}

# Get current git branch
parse_git_branch() {
declare BRANCH="$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')"
[[ -n "${BRANCH}" ]] && { STAT="$(parse_git_status)"; echo -ne "-[\e[33m${BRANCH}${STAT}\e[m]"; } || echo -n ""
}

# Set command prompt
export PS1="[\[\e[36m\]\t\[\e[m\]]-[\[\e[32m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]]-[\[\e[35m\]\W\[\e[m\]]\$(parse_git_branch)\n\\$> "

# Enable dynamic line wrap
shopt -s checkwinsize

# User Aliases
alias c='clear'
alias q='exit'
alias ..='cd ..'
alias ...='cd ..; cd ..'
alias ....='cd ..; cd ..; cd ..'
alias e='"$EDITOR"'
alias g='cd'
alias r='cd "$OLDPWD"'
alias l='ls -lh --color=auto'
alias ls='ls --color=auto'
alias ll='ls -lAh --color=auto'
alias la='ls -lARh --color=auto'
alias lt='ls -lARh --color=auto | grep "$1"'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gb='git branch'
alias gbc='git checkout'
alias gpl='git pull'
alias gph='git push'
alias b1='doas rc-service bluetoothd start && doas rfkill unblock bluetooth'
alias b0='doas rfkill block bluetooth && doas rc-service bluetoothd stop'
alias w1='doas rfkill unblock wifi'
alias w0='doas rfkill block wifi'
alias l1='openrgb -p Norm.orp'
alias l0='openrgb -p dark.orp'
