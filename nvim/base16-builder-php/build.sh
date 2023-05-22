#!/bin/sh

cat scheme.yaml | php base16-builder.php --template vim.mustache > schemes/colors/holo.vim
cat scheme.yaml | php base16-builder.php --template sh.mustache > schemes/shell/holo.sh
source schemes/shell/holo.sh
