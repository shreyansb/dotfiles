# --- Shreyans Bhansali ---

export PATH=$PATH:~/bin
export EDITOR=vim

# ---- color settings for ls ----
export TERM='xterm-color'
export CLICOLOR=1
export LSCOLORS='gxfxcxdxbxegedabagacad' # replace the dark blue for directories with a lighter color

# ---- git branch name and status for prompt ----
if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
	source /usr/local/git/contrib/completion/git-completion.bash
fi

parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
parse_git_branch() {
  git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
}

# ---- command prompt ----
# for all directories higher in the tree than the current directory,
# only show the first character of their name
#PROMPT_COMMAND='CurDir=`pwd|sed -e "s!$HOME!~!"|sed -E "s!([^/])[^/]+/!\1/!g"`'
PROMPT_COMMAND="echo -ne \"\033]0;$1 ($USER)\007\""
# [user@host /c/directory (git_branch*)]$ 
#PS1='[\u@\h \[\e[2;32m\]$CurDir\[\e[m\] \[\e[1;31m\]$(parse_git_branch)\[\e[m\]]\$ '
# [user@host /current/directory (git_branch*)]$ 
PS1='[\u@\h \[\e[2;32m\]\w\[\e[m\] \[\e[1;31m\]$(parse_git_branch)\[\e[m\]]\$ '

# ---- aliases ----
if [ -f ~/.bash_venmo_settings ]; then
    source ~/.bash_venmo_settings
fi
if [ -f ~/.bash_personal_settings ]; then
    source ~/.bash_personal_settings
fi
if [ -f ~/venmo-devops/.venmo_host_aliases ]; then
    source ~/venmo-devops/.venmo_host_aliases
fi

alias aliases="alias -p"	# prints list of all aliases

alias edit_bash="vim ~/.bash_profile"
alias reload_bash="source ~/.bash_profile"

alias ls="ls -G"
alias ll="ls -lG"
alias la="ls -lGa"
alias cd..="cd .."
alias ..="cd .."
alias mkdir="mkdir -p"

alias ackp="ack --type=python"
alias ackj="ack --type=javascript"
alias ackh="ack --type=html"
alias acki="ack -i"
