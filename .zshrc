### Powerlevel10k Instant Prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Color Scheme Sourcing
source ~/.config/nvim/schemes/shell/catppuccin-mocha.sh

### Colors for exa and ls
export LS_COLORS="$(vivid generate catppuccin-mocha)"

### Zim Configuration
# use catppuccin macchiato color scheme for zsh syntax highlighting
source ~/.zim/schemes/catppuccin_macchiato-zsh-syntax-highlighting.zsh

# use 'degit' tool by default
zstyle ':zim:zmodule' use 'degit'
ZIM_HOME=~/.zim

# download zimfw plugin manager if missing
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

# initialize modules
source ${ZIM_HOME}/init.zsh

### Aliases
alias ls="ls --color=always"
alias ll="exa -l -g --icons"
alias lla="ll -a"
alias vim="nvim"
alias python="python3"
alias mkdir="mkdir -pv"
alias fde="firefox-developer-edition"
alias g++d="g++ -ggdb -pedantic-errors -Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion -o"

### Git Aliases
alias ga='git add'
alias gc='git commit'
alias gpsh='git push'
alias gp='git pull'
alias gss='git status -s'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
