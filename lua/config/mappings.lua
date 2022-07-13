local utils = require('config.utils')
local imap = utils.imap
local nmap = utils.nmap
local vmap = utils.vmap

-- basic remaps
imap('jk', '<Esc>')
imap('<S-Tab>', '<C-d>')
nmap('<space>', ':')
nmap('<up>', '<c-p>') -- arrow keys for completions navigation
nmap('<down>', '<c-n>')
nmap('\\', ':pclose<CR>') -- close popup

-- leader maps
vim.g.mapleader = ','
nmap('<leader>h', '<C-W><C-H>')
nmap('<leader>j', '<C-W><C-J>')
nmap('<leader>k', '<C-W><C-K>')
nmap('<leader>l', '<C-W><C-L>')
nmap('<leader>n', ':set invnumber<CR>')
nmap('<leader>\\', ':noh<CR>')
