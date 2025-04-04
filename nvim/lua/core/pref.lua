vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.cursorline = false
vim.opt.autowrite = false
vim.opt.autoread = true
vim.opt.wrap = false

-- use spaces for tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.expandtab = true

-- set rel number and number
vim.opt.relativenumber = true
vim.opt.number = true

-- permanent undo
vim.opt.undodir = os.getenv( "HOME" ) .. '/.vimdid'
vim.opt.undofile = true

-- color column at 80 characters
vim.wo.colorcolumn = '80'

-- keybindings
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.keymap.set('n', 'H', '^', { noremap = false })
vim.keymap.set('n', 'L', '$', { noremap = false })
vim.keymap.set('n', 'dH', 'd^', { noremap = false })
vim.keymap.set('n', 'dL', 'd$', { noremap = false })
vim.keymap.set('n', 'th', ':bprev<enter>', { noremap = false })
vim.keymap.set('n', 'tl', ':bnext<enter>', { noremap = false })

-- centers search results
vim.keymap.set('n', 'n', 'nzz', { noremap = true, silent = true })
vim.keymap.set('n', 'N', 'Nzz', { noremap = true, silent = true })
vim.keymap.set('n', '*', '*zz', { noremap = true, silent = true })
vim.keymap.set('n', '#', '#zz', { noremap = true, silent = true })
vim.keymap.set('n', 'g*', 'g*zz', { noremap = true, silent = true })

-- custom vim commands
vim.cmd("command Paste execute \"write !curl -X POST https://api.pastes.dev/post " .. 
        "-H 'Content-Type: text/\" . &ft . \"' --data-binary '@-' | jq -r '\\\"ht" .. 
        "tps://pastes.dev/\\\" + .key'\"")
