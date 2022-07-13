
-------------------------------------------------------------------------------
-- Import/run external modules
-------------------------------------------------------------------------------
require('config.mappings')
require('setup_plugins')


-------------------------------------------------------------------------------
-- Appearance
-------------------------------------------------------------------------------
vim.opt.background = 'light'
vim.opt.termguicolors = true
vim.g.solarized_extra_hi_groups = 1
vim.cmd('colorscheme solarized8_low')
vim.cmd('hi Comment cterm=italic')
--vim.opt.guioptions:remove('m,T,r,L')
vim.opt.guicursor:append('n-v-c:blinkon0')

-------------------------------------------------------------------------------
-- Editor stuff
-------------------------------------------------------------------------------

vim.cmd('autocmd FileType * set formatoptions-=o')
vim.opt.mouse = 'a'
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.fileformat = 'unix'
vim.wo.wrap = false

-- configure backspace so it acts as it should
vim.opt.backspace = 'eol,start,indent'
vim.opt.whichwrap:append('<,>,h,l')
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.scrolloff = 4
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.clipboard = 'unnamedplus' -- linux: install xclip to work
vim.opt.autoread = true
vim.opt.splitbelow = true

-------------------------------------------------------------------------------
-- Focus mode
-------------------------------------------------------------------------------
vim.cmd [[
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!
    let g:goyo_width=100
    let g:goyo_height=95

    let g:limelight_default_coefficient = 0.7
    let g:limelight_paragraph_span = 0
]]

-------------------------------------------------------------------------------
-- Git settings
-------------------------------------------------------------------------------
vim.cmd [[
    command Gstatus Git
    command Gcommit Git commit
    command Gdiff Git diff
    autocmd FileType fugitive nmap <buffer> q gq
    autocmd FileType fugitive nmap <buffer> c :Gcommit<CR>
    autocmd FileType fugitiveblame nmap <buffer> q gq
    autocmd FileType git nmap <buffer> q :q<CR>
]]
-- This function doesnt seem to be defined
-- vim.api.nvim_add_user_command('Gstatus', 'Git', { nargs=0 })
-- vim.api.nvim_add_user_command('Gdiff', 'Git diff', { nargs=0 })

-------------------------------------------------------------------------------
-- Language specific settings
-------------------------------------------------------------------------------

-- Python


-- Haskell

-- Latex
vim.cmd [[
    autocmd FileType tex,latex nnoremap <leader>c :!pdflatex %<cr>
    autocmd FileType tex,latex nnoremap <leader>b :!bibtex %:r<cr>
]]

-------------------------------------------------------------------------------
-- statusline
-------------------------------------------------------------------------------
vim.opt.laststatus = 2
vim.opt.statusline = ' %m %f%= %{FugitiveStatusline()} %{&fileformat}  %{&fileencoding}  %{&filetype}  %p%%  LN %l:%c '
