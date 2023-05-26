#!/bin/sh

cat scheme.yaml | php base16-builder.php --template vim.mustache > schemes/colors/gravity.vim
cat scheme.yaml | php base16-builder.php --template sh.mustache > schemes/shell/gravity.sh
source schemes/shell/gravity.sh
