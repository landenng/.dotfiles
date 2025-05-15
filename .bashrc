# PROMPT
PS1='{\u@\h \W}\\$ '

# EXPORTS
export EDITOR="vim"
export HISTSIZE=1000
export PATH=$PATH:/usr/local/go/bin

# ALIASES
alias ls="eza -g --icons"
alias ll="eza -gl --icons"
alias lla="eza -gla --icons"

# STARSHIP
eval "$(starship init bash)"
