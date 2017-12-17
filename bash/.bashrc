# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Get the git auto-completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
# make alias for git work with git auto-completion
  __git_complete ga _git_add
  __git_complete gb _git_branch
  __git_complete gc _git_checkout
  __git_complete gd _git_diff
  __git_complete gl _git_log
  __git_complete gp _git_pull
  __git_complete gs _git_status
fi


# alias definition
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'

alias em='emacs'

alias ll='ls -al'

alias ~='cd ~'
alias ..='cd ..'
alias ...='cd ../../'

alias ga='git add'
alias gb='git branch'
alias gc='git checkout'
alias gd='git diff'
alias gl='git log'
alias gp='git pull'
alias gs='git status'

# set path for coding
alias code='cd /Users/junyiliu/Documents/Coding'

# color setting for LS
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad

# highlight grep matches
export GREP_OPTIONS='--color=auto'

# set GOPATH
export GOPATH=$HOME/Documents/Coding/Go

# get current branch in git repo
function parse_git_branch() {
        BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
        if [ ! "${BRANCH}" == "" ]
        then
                STAT=`parse_git_dirty`
                echo "[${BRANCH}${STAT}]"
        else
                echo ""
        fi
}

# get current status of git repo
function parse_git_dirty {
        status=`git status 2>&1 | tee`
        dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
        untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
        ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
        newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
        renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
        deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
        bits=''
        if [ "${renamed}" == "0" ]; then
                bits=">${bits}"
        fi
        if [ "${ahead}" == "0" ]; then
                bits="*${bits}"
        fi
        if [ "${newfile}" == "0" ]; then
                bits="+${bits}"
        fi
        if [ "${untracked}" == "0" ]; then
                bits="?${bits}"
        fi
        if [ "${deleted}" == "0" ]; then
                bits="x${bits}"
        fi
        if [ "${dirty}" == "0" ]; then
                bits="!${bits}"
        fi
        if [ ! "${bits}" == "" ]; then
                echo " ${bits}"
        else
                echo ""
        fi
}

# customize the shell prompt 
export PS1="\[\e[32m\]\u\[\e[m\]@\h \[\e[36m\]\W\[\e[m\]\[\e[31m\]\`parse_git_branch\`\[\e[m\$\] "
