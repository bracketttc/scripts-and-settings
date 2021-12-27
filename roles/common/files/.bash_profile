# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

export PS1="${RESET}\u@\h ${GREEN}\W${YELLOW}\$(parse_git_branch)${RESET}\n$ "

# History options

#[[ "${PROMPT_COMMAND}" =~ "history -a" ]] || export PROMPT_COMMAND="history -a; ${PROMPT_COMMAND}"

# Append instead of overwrite
shopt -s histappend

# Infinite history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
export HISTFILE=~/.bash_eternal_history
