local map = function(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, {noremap = true})
end

local nmap = function(shortcut, command)
    map('n', shortcut, command)
end

local imap = function(shortcut, command)
    map('i', shortcut, command)
end

local vmap = function(shortcut, command)
    map('v', shortcut, command)
end

local tmap = function(shortcut, command)
    map('t', shortcut, command)
end


-- vim.api.nvim_create_user_command("ToggleBackground", function()
--     vim.cmd('set background=' .. (vim.o.background == 'dark' and 'light' or 'dark'))
-- end, {range = false, nargs = 0})

-- basic remaps
nmap('<space>', ':')
-- nmap('<up>', '<c-p>') -- arrow keys for completions navigation
-- nmap('<down>', '<c-n>')
if not vim.g.vscode then
    imap('jk', '<Esc>')
    tmap('jk', '<C-\\><C-n>')
    nmap('\\', ':pclose<CR>') -- close popup

    -- leader maps
    vim.g.mapleader = ','
    nmap('<leader>h', '<C-W><C-H>')
    nmap('<leader>j', '<C-W><C-J>')
    nmap('<leader>k', '<C-W><C-K>')
    nmap('<leader>l', '<C-W><C-L>')
    nmap('<leader>n', ':set invnumber<CR>')
    nmap('<leader>\\', ':noh<CR>')
    nmap('<leader>d', ':ToggleBackground<CR>')

    nmap('q', ':silent! normal za<CR>:echo \'\'<CR>') -- toggle folding

    -- if zen-mode installed
    ok, _ = pcall(require, 'zen-mode')
    if ok then
        nmap('<leader>z', ':ZenMode<CR>')
    end

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
