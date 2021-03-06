
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
    use 'williamboman/nvim-lsp-installer'
    use 'onsails/lspkind.nvim'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'github/copilot.vim' -- installed/setup for auth purposes

    -- This isn't fully baked yet so I'm not including it for now.
    -- use { "zbirenbaum/copilot.lua",
    --     after = {}, --whichever statusline plugin you use here
    --     config = function ()
    --         vim.defer_fn(function() require("copilot").setup({
    --             -- TODO write a function that returns the setup config
    --             -- and keep that in a separate module
    --             cmp = {
    --                 enabled = true,
    --                 method = "getPanelCompletions",
    --             },
    --             panel = { -- no config options yet
    --                 enabled = true,
    --             },
    --             ft_disable = {},
    --             server_opts_overrides = {},
    --         }) end, 100)
    --     end,
    -- }

    -- use {
    --     "zbirenbaum/copilot-cmp",
    --     after = 'copilot.lua'
    -- }


    -- Treesitter -------------------------------------------------------------
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }
    -- at the moment python indentation breaks with treesitter
    -- so fallback to this for now and check back periodically
    use {
        'Vimjas/vim-python-pep8-indent',
        run = function() vim.cmd('let g:pymode_indent=0') end
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

    -- Misc Editor ui stuff --------------------------------------------------
    -- use 'liuchengxu/vista.vim'
    use 'nvim-lualine/lualine.nvim'
    use 'junegunn/goyo.vim'
    use 'junegunn/limelight.vim'
    use 'kyazdani42/nvim-web-devicons'
    use { 'lukas-reineke/indent-blankline.nvim', } -- TODO fix toggle

    -- Orgmode ---------------------------------------------------------------
    use {'nvim-orgmode/orgmode', config = function()
        require('orgmode').setup{}
    end }

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
    use {
        'catppuccin/nvim',
        as='catppuccin',
        run = 'CatpuccinCompile',
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
