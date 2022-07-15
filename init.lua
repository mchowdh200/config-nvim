
-------------------------------------------------------------------------------
-- Import/run external modules
-------------------------------------------------------------------------------
require 'setup_plugins'
require 'completions'
require 'lsp'
require 'config.mappings'
require 'config.treesitter'


-------------------------------------------------------------------------------
-- Appearance
-------------------------------------------------------------------------------
vim.opt.background = 'dark'
vim.opt.termguicolors = true

require('config.catppuccin_config')
vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha
vim.cmd('colorscheme catppuccin')

vim.opt.guicursor:append('n-v-c:blinkon0')
-- vim.g.solarized_extra_hi_groups = 1
-- vim.cmd('colorscheme space_vim_theme')
-- vim.cmd('hi Comment cterm=italic')
--vim.opt.guioptions:remove('m,T,r,L')

-------------------------------------------------------------------------------
-- Editor stuff
-------------------------------------------------------------------------------

vim.cmd('autocmd FileType * set formatoptions-=o')
vim.opt.mouse = 'a'
vim.opt.updatetime = 500 -- for update latency on floating window
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.fileformat = 'unix'
vim.wo.wrap = false
vim.opt.autochdir = true

-- configure backspace so it acts as it should
vim.opt.backspace = 'eol,start,indent'
vim.opt.whichwrap:append('<,>,h,l')
vim.opt.ruler = true
vim.opt.signcolumn = 'yes'
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
    command Gpush Git push
    command Gpull Git pull
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
-- vim.opt.statusline = ' %m %f%= %{FugitiveStatusline()} %{&fileformat}  %{&fileencoding}  %{&filetype}  %p%%  LN %l:%c '
vim.opt.statusline = ' %m %{expand(\'%:p:h:t\')}/%t%= %{FugitiveStatusline()} %{&fileformat}  %{&fileencoding}  %{&filetype}  %p%%  LN %l:%c '
