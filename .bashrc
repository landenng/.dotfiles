# PROMPT
PS1='{\u@\h \W}\\$ '

# EXPORTS
export EDITOR="vim"
export HISTSIZE=1000
export PATH=$PATH:/usr/local/go/bin

# ALIASES
alias ls="exa -g --icons"

# STARSHIP
eval "$(starship init bash)"
