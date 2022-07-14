
-------------------------------------------------------------------------------
-- Install/configure plugins
-------------------------------------------------------------------------------
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end
require('packer').startup(function(use)
    -- basic insert mode stuff ------------------------------------------------
    use 'wbthomason/packer.nvim'
    use 'mhinz/vim-startify'
    use 'jiangmiao/auto-pairs'
    use 'tpope/vim-endwise'
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'

    -- Git stuff --------------------------------------------------------------
    use 'tpope/vim-fugitive'

    -- Autocompletions --------------------------------------------------------
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'github/copilot.vim'

    -- Treesitter -------------------------------------------------------------
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }

    -- Telescope --------------------------------------------------------------
    use {
        {
            'nvim-telescope/telescope.nvim',
            requires = {
                'nvim-lua/popup.nvim',
                'nvim-lua/plenary.nvim',
                'telescope-frecency.nvim',
                'telescope-fzf-native.nvim',
                'nvim-telescope/telescope-ui-select.nvim',
            },
            wants = {
                'popup.nvim',
                'plenary.nvim',
                'telescope-frecency.nvim',
                'telescope-fzf-native.nvim',
            },
            setup = [[require('config.telescope_setup')]],
            config = [[require('config.telescope')]],
            cmd = 'Telescope',
            module = 'telescope',
        },
        {
            'nvim-telescope/telescope-frecency.nvim',
            after = 'telescope.nvim',
            requires = 'tami5/sqlite.lua',
        },
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            run = 'make',
        },
    }

    -- Misc Editor stuff ------------------------------------------------------
    use 'junegunn/goyo.vim'
    use 'junegunn/limelight.vim'
    -- use { 'lukas-reineke/indent-blankline.nvim', } -- TODO fix toggle

    -- Tmux -------------------------------------------------------------------
    use 'tmux-plugins/vim-tmux-focus-events'

    -- Themes -----------------------------------------------------------------
    use 'savq/melange'
    use 'lifepillar/vim-solarized8'
    use 'liuchengxu/space-vim-theme'
    use 'rakr/vim-one'
    use 'NLKNguyen/papercolor-theme'
    use 'chriskempson/vim-tomorrow-theme'
    use 'ErichDonGubler/vim-sublime-monokai'
    use 'jnurmine/Zenburn'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
