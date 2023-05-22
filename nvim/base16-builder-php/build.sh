#!/bin/sh

cat scheme.yaml | php base16-builder.php --template vim.mustache > colors/holo.vim
cat scheme.yaml | php base16-builder.php --template sh.mustache > holo.sh
source holo.sh
