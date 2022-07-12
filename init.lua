
-------------------------------------------------------------------------------
-- Plugins
-------------------------------------------------------------------------------
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end
require('packer').startup(function(use)
  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'
  
  -- basic insert mode stuff
  use 'wbthomason/packer.nvim'
  use 'mhinz/vim-startify'
  use 'jiangmiao/auto-pairs'
  use 'tpope/vim-endwise'
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'

  -- Git stuff
  use 'tpope/vim-fugitive'
  -- TODO neovim/nvim-lspconfig
  use 'github/copilot.vim'

  -- Editor stuff
  use 'junegunn/goyo.vim'
  use 'junegunn/limelight.vim'

  -- Tmux
  use 'tmux-plugins/vim-tmux-focus-events'

  -- Themes
  use 'michaelmalick/vim-colors-bluedrake'
  use 'fxn/vim-monochrome'
  use 'arcticicestudio/nord-vim'
  use 'lifepillar/vim-solarized8'
  use 'liuchengxu/space-vim-dark'
  use 'rakr/vim-one'
  use 'NLKNguyen/papercolor-theme'
  use 'chriskempson/vim-tomorrow-theme'
  use 'ErichDonGubler/vim-sublime-monokai'
  use 'nightsense/snow'
  use 'nightsense/cosmic_latte'
  use 'nightsense/carbonized'
  use 'nightsense/stellarized'
  use 'jnurmine/Zenburn'
  use 'wadackel/vim-dogrun'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-------------------------------------------------------------------------------
-- key mappings
-------------------------------------------------------------------------------
-- helper functions for key mappings
function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, {noremap = true})
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

-- basic remaps
imap('jk', '<Esc>')
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

-------------------------------------------------------------------------------
-- Appearance
-------------------------------------------------------------------------------
vim.cmd('set background=dark')
vim.cmd('set termguicolors')
vim.g.solarized_extra_hi_groups = 1
vim.cmd('colorscheme solarized8')
vim.cmd('hi Comment cterm=italic')
--vim.opt.guioptions:remove('m,T,r,L')
vim.opt.guicursor:append('n-v-c:blinkon0')

-------------------------------------------------------------------------------
-- Editor stuff
-------------------------------------------------------------------------------
vim.opt.mouse = 'a'
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.fileformat = 'unix'
-- vim.opt.nowrap = true
vim.wo.wrap = true
imap('<S-Tab>', '<C-d>')

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
vim.opt.clipboard = 'unnamedplus'
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
-- '\ %m\ %f%=\ %{FugitiveStatusline()}\ %{&fileformat}\ \ %{&fileencoding}\ \ %{&filetype}\ \ %p%%\ \ LN\ %l:%c\ '
