#
# ~/.bashrc
#

# Get current status of git repo
function parse_git_status {
declare status="$(git status 2>&1 | tee)"
declare dirty="$(echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?")"
declare untracked="$(echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?")"
declare ahead="$(echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?")"
declare newfile="$(echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?")"
declare renamed="$(echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?")"
declare deleted="$(echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?")"
declare bits=''
if [[ "${renamed}" -eq 0 ]]; then bits="*${bits}"; fi
if [[ "${ahead}" -eq 0 ]]; then bits=">${bits}"; fi
if [[ "${newfile}" -eq 0 ]]; then bits="+${bits}"; fi
if [[ "${untracked}" -eq 0 ]]; then bits="?${bits}"; fi
if [[ "${deleted}" -eq 0 ]]; then bits="-${bits}"; fi
if [[ "${dirty}" -eq 0 ]]; then bits="!${bits}"; fi
if [[ ! "${bits}" == "" ]]; then echo " ${bits}"; else echo ""; fi
}

# Get current git branch
function parse_git_branch() {
declare BRANCH="$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')"
if [[ -n "${BRANCH}" ]]; then
	STAT="$(parse_git_status)"
	echo -e "[\e[33m${BRANCH}${STAT}\e[m]"
else
	echo ""
fi
}

# Set command prompt
export PS1="[\[\e[36m\]\t\[\e[m\]]-[\[\e[32m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]]-[\[\e[35m\]\W\[\e[m\]]\$(parse_git_branch)\n\\$> "

# Set umask
umask 027

# Preferred text editor
export EDITOR=nvim

# Limit .bash_history memory to session only
export HISTFILESIZE=0

# Increase session history cache
export HISTSIZE=1000000

# Ignore duplicates and commands starting with a space
export HISTCONTROL='ignoreboth'

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
alias gco='git checkout'
alias gb='git branch'
alias gpl='git pull'
alias gph='git push'
alias light='openrgb -p Norm.orp'
alias dark='openrgb -p dark.orp'
alias ncmpcpp='ncmpcpp --config=~/.config/ncmpcpp/config'
