###-------------------------- BLESH --------------------------###
[[ $- == *i* ]] && source /usr/share/blesh/ble.sh --noattach

###------------------------- PROMPT -------------------------###
PS1="\e[01;34m\]{ \w } \e[00;31m\]\$ \e[01;37m\]"

###------------------------- EXPORTS -------------------------###
export LS_COLORS="$(vivid generate ~/.config/rose-pine-moon.yml)"
export BROWSER="firefox-developer-edition"
export EDITOR="nvim"
export HISTSIZE=1000

###------------------------- SOURCING -------------------------###
source $HOME/.config/nvim/schemes/shell/yui.sh
source $HOME/dev/z/z.sh

###------------------------- ALIASES -------------------------###
alias ls="ls --color=always"
alias ll="exa -l -g --icons"
alias lla="ll -a"
alias vim="nvim"
alias python="python3"
alias mkdir="mkdir -pv"
alias fde="firefox-developer-edition"

###------------------------- FUNCTIONS -------------------------###
mirror() {
    for d in $(xrandr | grep ' connected' | cut -d' ' -f1 | grep -v 'eDP-1'); do
        printf "--%s--\n" $d;
        xrandr --output eDP --rate 60 --mode 1920x1080 --fb 1920x1080 --panning 1920x1080* --output $d --mode 1920x1080 --same-as eDP
    done
}

mirrorc() {
    xrandr --output eDP --rate 60 --mode 1920x1080 --fb 1920x1080 --panning 1920x1080* --output DP-1-0 --mode 1920x1080 --same-as eDP
}

mirrorhdmi() {
    xrandr --output eDP --rate 60 --mode 1920x1080 --fb 1920x1080 --panning 1920x1080* --output HDMI-A-0 --mode 1920x1080 --same-as eDP
}

mkhtml() {
    if [ -d "$1" ]; then
        echo "Directory $1 already exists." >&2
    fi

    cp -r $HOME/templates/html "$1"
}

mkaoc() {
    if [ -d "$1" ]; then
        echo "Directory $1 already exists." >&2
    fi

    cp -r $HOME/templates/aoc "$1"
}

###-------------------------- BLESH --------------------------###
[[ ${BLE_VERSION-} ]] && ble-attach
