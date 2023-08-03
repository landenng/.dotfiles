# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

PATH="$PATH:$HOME/.local/bin/"
PATH="$PATH:$HOME/.cargo/bin/"
print_before_the_prompt () {
    dir=$PWD
    home=$HOME
    dir=${dir/"$HOME"/"~"}
    title=${dir/"~/"/""}
    printf "\n $red%s: $bldpur%s $green%s\n$reset" "$HOST_NAME" "$dir" "$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')"
    PS1="$(pwd) > "
}

PROMPT_COMMAND=print_before_the_prompt
# PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"


mkcd () {
    mkdir $1 && cd $1
}

git-log () {
    git log --author=$1 --shortstat $2 | \
    awk '/^ [0-9]/ { f += $1; i += $4; d += $6 } \
    END { printf("%d files changed, %d insertions(+), %d deletions(-)", f, i, d) }'
}

js () {
    node "$HOME/.scripts/$1.js" $2
}

extract () {
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
        echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
        return 1
    else
        for n in $@
        do
            if [ -f "$n" ] ; then
                case "${n%,}" in
                    *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                    tar xvf "$n"       ;;
                    *.lzma)      unlzma ./"$n"      ;;
                    *.bz2)       bunzip2 ./"$n"     ;;
                    *.rar)       unrar x -ad ./"$n" ;;
                    *.gz)        gunzip ./"$n"      ;;
                    *.zip)       unzip ./"$n"       ;;
                    *.z)         uncompress ./"$n"  ;;
                    *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                    7z x ./"$n"        ;;
                    *.xz)        unxz ./"$n"        ;;
                    *.exe)       cabextract ./"$n"  ;;
                    *)
                        echo "extract: '$n' - unknown archive method"
                        return 1
                    ;;
                esac
            else
                echo "'$n' - file does not exist"
                return 1
            fi
        done
    fi
}

home () {
    cd ~
    clear
    source ~/.bashrc
}

new-js () {
    touch index.js
    echo '<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>

    <script src="index.js"></script>
</body>
    </html>' > index.html
}

mvncp () {
    cp "$PROJDIR/$1/target/$2" "./plugins/"
}

projdir () {
    cd $PROJDIR
    if ! [ -z $1 ] ; then
        cd $1
    fi
}

reload () {
    unalias -a
    source ~/.bashrc
}

my-ip () {
    printf " --- IP Information --- \n"
    printf "${blue}Internal: ${reset}%s\n" $(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | head -1)
    printf "${blue}External: ${reset}%s\n" $(curl -s http://ifconfig.io)
    printf " ---------------------- \n"
}

new-proj () {
    if [ -z $1 ] ; then
        echo "Usage: new-project <project_name>"
        return 1
    fi
    if [ -d $1 ] ; then
        echo "Directory '$1' already exists"
        return 1
    fi
    mkdir $1
    cd $1
    license Apache-2.0
    
    if ! [ -z $2 ] ; then
        if [ $2 = "js" ] ; then
            lang="node"
        else 
            lang=$2
        fi
        gitignore $lang
        if [ $lang = "node" ] ; then
            mkdir src
            touch src/index.js
            echo $'{\n"name": "'"$1"$'",\n"version": "1.0.0",\n"description": "",\n"main": "src/index.js",\n"scripts": {\n"start":"node src/index.js",\n"test": "echo \\"Error: no test specified\\" && exit 1"\n},\n"keywords": [],\n"author": "",\n"license": "Apache-2.0"\n}' > package.json
        fi
    fi
    
    echo "# $(basename $PWD)" > README.md
}

bg () {
	exec nohup $@ &> /dev/null &
}

source ~/.config/nvim/base16-builder-php/schemes/shell/catppuccin.sh

# -------
# Aliases
# -------
alias ls="ls --color=always"
alias ll="exa -l -g --icons"
alias lla="ll -a"
alias vim="nvim"
alias python="python3"
alias mkdir="mkdir -pv"
alias fde="firefox-developer-edition"

# ----------------------
# Git Aliases
# ----------------------
alias ga='git add'
alias gaa='git add -A'
alias gas='git add src/'
alias gc='git commit'
alias gcm='git commit -m'
alias gd='git diff'
alias gi='git init'
alias gl='git log'
alias gp='git pull'
alias gpsh='git push'
alias gss='git status -s'
alias gsa='git-stats -a'


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ---------------
# zsh plugins
# ---------------
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /home/holo/.zsh/catppuccin_macchiato-zsh-syntax-highlighting.zsh
source /home/holo/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /home/holo/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

. /usr/share/z/z.sh
