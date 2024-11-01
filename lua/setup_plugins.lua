
-------------------------------------------------------------------------------
-- Install/configure plugins
-------------------------------------------------------------------------------
if vim.g.vscode then
    return
end

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

    -- Remote editing ---------------------------------------------------------
    use {
        "amitds1997/remote-nvim.nvim",
        requires = {
            "nvim-lua/plenary.nvim", -- For standard functions
            "MunifTanjim/nui.nvim", -- To build the plugin UI
            "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
        },
        config = [[require("remote-nvim").setup()]],
    }

    -- cmp, dap, lsp ----------------------------------------------------------
    use {

        -- lsp -----------------------------------
        { 'onsails/lspkind.nvim', config = [[require('config.lspkind')]] },
        {
            'neovim/nvim-lspconfig',
            requires = {
                'onsails/lspkind.nvim',
                'williamboman/mason.nvim',
            },
            after = {
                'lspkind.nvim',
                'mason.nvim'
            },
            config = [[require('lsp')]]
        },

        {
            'williamboman/mason.nvim',
            config = [[require('config.mason')]]
        },

        {
            'jose-elias-alvarez/null-ls.nvim',
            after = {
                'mason.nvim',
                'nvim-lspconfig',
            },
            config = [[require('config.null_ls_setup')]]
        },

        -- dap -----------------------------------
        -- {
        --     'mfussenegger/nvim-dap',
        --     requires = { 'theHamsta/nvim-dap-virtual-text', },
        --     config = [[require('config.nvim_dap')]]
        -- },
        -- {
        --     'theHamsta/nvim-dap-virtual-text',
        --     config=[[require('config.dap_virtual_text')]],
        -- },
        -- {
        --     'rcarriga/nvim-dap-ui',
        --     requires = 'mfussenegger/nvim-dap',
        --     config=[[require('config.dap_ui')]],
        -- },

        -- cmp -----------------------------------

        {
            'hrsh7th/nvim-cmp',
            requires = {
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-nvim-lsp-signature-help',
                'L3MON4D3/LuaSnip',
                'saadparwaiz1/cmp_luasnip',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-cmdline',
            },
            -- after = 'lspkind.nvim',
            config = [[require('completions')]],

        },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lsp-signature-help' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-cmdline' },
    }

    use {
        'github/copilot.vim',
        config = [[require('config.copilot')]],
    }

    -- Treesitter -------------------------------------------------------------
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
        config = [[require('config.treesitter')]],
    }

    use {
        'nvim-treesitter/nvim-treesitter-context',
        config = [[require('config.treesitter_context')]],
    }

    -- at the moment python indentation breaks with treesitter
    -- so fallback to this for now and check back periodically
    use {
        'Vimjas/vim-python-pep8-indent',
        run = function() vim.cmd('let g:pymode_indent=0') end
    }

    use 'raivivek/vim-snakemake'

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
            -- requires = 'kkharji/sqlite.lua',
        },
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            run = 'make',
            --run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' ,
        },
    }

    -- Misc Editor ui stuff --------------------------------------------------
    -- use 'liuchengxu/vista.vim'
    use { 'nvim-lualine/lualine.nvim',
        config = [[require('config.lualine')]],
    }
    use 'junegunn/limelight.vim'
    use {'folke/zen-mode.nvim',
        config = function()
            require("config.zen-mode")
        end
    }
    use 'kyazdani42/nvim-web-devicons'
    use { 'lukas-reineke/indent-blankline.nvim',
        config=function()
            require('config.indent-blankline')
        end
    } -- TODO fix toggle

    use { 'HampusHauffman/block.nvim',
        config = function()
            require("config.block")
        end
    }

    -- Orgmode ---------------------------------------------------------------
    -- use {'nvim-orgmode/orgmode', config = function()
    --     local o = require('orgmode')
    --     o.setup{}
    --     o.setup_ts_grammar()
    -- end }

    -- Tmux -------------------------------------------------------------------
    use 'tmux-plugins/vim-tmux-focus-events'

    -- Themes -----------------------------------------------------------------
    use {
        'Verf/deepwhite.nvim',
        config = function ()
                require('deepwhite').setup({low_blue_light = false})
            end
    }
    use 'lifepillar/vim-solarized8'
    use 'liuchengxu/space-vim-theme'
    use 'chriskempson/vim-tomorrow-theme'
    use 'ErichDonGubler/vim-sublime-monokai'
    use 'yashguptaz/calvera-dark.nvim'
    use {
        'catppuccin/nvim',
        as='catppuccin',
        run = 'CatpuccinCompile',
    }
    use {
        'folke/tokyonight.nvim',
        config = function () require('config.tokyonight') end
    }


    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
