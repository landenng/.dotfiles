#!/bin/sh

cat scheme.yaml | php base16-builder.php --template vim.mustache > schemes/colors/catppuccin.vim
cat scheme.yaml | php base16-builder.php --template sh.mustache > schemes/shell/catppuccin.sh
source schemes/shell/catppuccin.sh
