###------------------------- EXPORTS -------------------------###
export LS_COLORS="$(vivid generate /usr/share/vivid/rose-pine-moon.yml)"
export BROWSER="firefox-developer-edition"
export EDITOR="nvim"
export HISTSIZE=1000

###------------------------- SOURCING -------------------------###
source ~/.config/nvim/schemes/shell/yui.sh

###------------------------- PROMPT -------------------------###
PS1="\e[01;34m\]{ \w } \e[00;31m\]\$ \e[01;37m\]"

###------------------------- ALIASES -------------------------###
alias ls="ls --color=always"
alias ll="exa -l -g --icons"
alias lla="ll -a"
alias vim="nvim"
alias python="python3"
alias mkdir="mkdir -pv"
alias fde="firefox-developer-edition"

###------------------------- FUNCTIONS -------------------------###
mkhtml() {
    if [ -d "$1" ]; then
        echo "Directory $1 already exists." >&2
    fi

    cp -r $HOME/templates/html-project "$1"
}
