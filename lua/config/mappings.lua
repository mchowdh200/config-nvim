local utils = require('config.utils')
local imap = utils.imap
local nmap = utils.nmap
local vmap = utils.vmap

-- basic remaps
nmap('<space>', ':')
-- nmap('<up>', '<c-p>') -- arrow keys for completions navigation
-- nmap('<down>', '<c-n>')
if not vim.g.vscode then
    imap('jk', '<Esc>')
    nmap('\\', ':pclose<CR>') -- close popup

    -- leader maps
    vim.g.mapleader = ','
    nmap('<leader>h', '<C-W><C-H>')
    nmap('<leader>j', '<C-W><C-J>')
    nmap('<leader>k', '<C-W><C-K>')
    nmap('<leader>l', '<C-W><C-L>')
    nmap('<leader>n', ':set invnumber<CR>')
    nmap('<leader>\\', ':noh<CR>')
    nmap('q', ':silent! normal za<CR>:echo \'\'<CR>') -- toggle folding

    vim.cmd[[
    autocmd FileType tex nnoremap <buffer> <F5> :w<CR>:!pdflatex %<CR>
    ]]
end


-- ok, _ = pcall(require, 'copilot')
-- if ok then
--     vim.cmd[[
--         imap <silent><script><expr> <S-Tab> copilot#Accept("\<CR>")
--     ]]
-- end
