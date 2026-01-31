#!/bin/bash
# Create the links for all the config files to this directory
# _Note: This will rename any previous dir to "${DIR}_OLD"_

function mkln () {
    from="$1"
    to="$2"

    if ! [ -L "$to" ]; then # Move if it is not a link
        mv "$to" "$to_OLD" > /dev/null && echo "Moved $to to $to_OLD"
    else # Otherwise, take it out back
        target="$(readlink -f "$to")"
        rm "$to" && echo "Removed previous link ${to/$HOME/~} -> ${target/$HOME/~}"
    fi
    ln -s "$(pwd)/$from" "$to"
}

mkln ".vimrc"              "$HOME/.vimrc"
mkln ".bashrc"             "$HOME/.bashrc"
mkln ".inputrc"            "$HOME/.inputrc"
mkln "nvim"                "$HOME/.config/nvim"
mkln ".tmux.conf"          "$HOME/.tmux.conf"
mkln "alacritty"           "$HOME/.config/alacritty"
mkln "niri"                "$HOME/.config/niri"
mkln "noctalia"            "$HOME/.config/noctalia"
