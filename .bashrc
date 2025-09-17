# PROMPT
PS1='{\u@\h \W}\\$ '

# EXPORTS
export EDITOR="vim"
export HISTSIZE=1000
export PATH=$PATH:/home/landen/.cargo/bin:/usr/local/go/bin

# ALIASES
alias ls="eza -g --icons"
alias ll="eza -gl --icons"
alias lla="eza -gla --icons"

alias gpp="g++ -std=c++23 -pedantic-errors -Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion -Werror"
alias gppdb="g++ -std=c++23 -pedantic-errors -ggdb -Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion -Werror"

# STARSHIP
eval "$(starship init bash)"
. "$HOME/.cargo/env"
