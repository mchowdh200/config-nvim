-------------------------------------------------------------------------------
-- Install/configure plugins
-------------------------------------------------------------------------------

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ","

require("lazy").setup({
	spec = {
		-- basic insert mode stuff --------------------------------------------
		{ "mhinz/vim-startify" },
		{ "jiangmiao/auto-pairs" },
		{ "tpope/vim-endwise" },
		{ "tpope/vim-surround" },
		{ "tpope/vim-commentary" },

		-- Git stuff ----------------------------------------------------------
		{ "tpope/vim-fugitive" },

		-- lsp ----------------------------------------------------------------
		{
			"onsails/lspkind.nvim",
			config = function()
				require("config.lspkind")
			end,
		},
		{
			"neovim/nvim-lspconfig",
			dependencies = {
				"onsails/lspkind.nvim",
				"williamboman/mason.nvim",
			},
			config = function()
				require("lsp")
			end,
		},

		{
			"williamboman/mason.nvim",
			config = function()
				require("config.mason")
			end,
		},

		{
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			dependencies = {
				"williamboman/mason.nvim",
			},
			config = function()
				require("mason-tool-installer").setup({
					ensure_installed = {
						"bash-language-server",
						"black",
						"clang-format",
						"clangd",
						"isort",
						"lua-language-server",
						-- {"nginx-language-server", version = "0.7.1"},
						"nginx-language-server",
						"prettier",
						"pyright",
						"snakefmt",
						"stylua",
						"zls",
					},
				})
			end,
		},

		-- {
		--     'jose-elias-alvarez/null-ls.nvim',
		--     -- after = {
		--     --     'mason.nvim',
		--     --     'nvim-lspconfig',
		--     -- },
		--     config = function () require('config.null_ls_setup') end
		-- },
		{
			"stevearc/conform.nvim",
			event = { "BufReadPre", "BufNewFile" },
			config = function()
				require("config.conform")
			end,
		},

		-- cmp ----------------------------------------------------------------
		{
			"hrsh7th/nvim-cmp",
			config = function()
				require("completions")
			end,
		},
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-nvim-lsp-signature-help" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-cmdline" },

		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		},

		{
			"github/copilot.vim",
			config = function()
				require("config.copilot")
			end,
		},

		-- Treesitter ---------------------------------------------------------
		{
			"nvim-treesitter/nvim-treesitter",
			build = function()
				require("nvim-treesitter.install").update({ with_sync = true })
			end,
			config = function()
				require("config.treesitter")
			end,
		},

		{
			"nvim-treesitter/nvim-treesitter-context",
			config = function()
				require("config.treesitter_context")
			end,
		},

		-- at the moment python indentation breaks with treesitter
		-- so fallback to this for now and check back periodically
		{
			"Vimjas/vim-python-pep8-indent",
			build = function()
				vim.cmd("let g:pymode_indent=0")
			end,
		},

		{
			"mchowdh200/vim-snakemake",
		},

		-- Telescope ----------------------------------------------------------
		{
			"nvim-telescope/telescope.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			init = function()
				require("config.telescope_setup")
			end,
			config = function()
				require("config.telescope")
			end,
			cmd = "Telescope",
		},
		{
			"nvim-telescope/telescope-frecency.nvim",
		},
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		{
			"nvim-telescope/telescope-ui-select.nvim",
		},

		-- Misc Editor ui stuff ----------------------------------------------
		-- {
		--     "folke/noice.nvim",
		--     event = "VeryLazy",
		--     opts = {
		--         -- add any options here
		--     },
		--     dependencies = {
		--         -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		--         "MunifTanjim/nui.nvim",
		--         -- OPTIONAL:
		--         --   `nvim-notify` is only needed, if you want to use the notification view.
		--         --   If not available, we use `mini` as the fallback
		--         "rcarriga/nvim-notify",
		--     }
		-- },
		-- { 'MunifTanjim/nui.nvim' },
		-- { "rcarriga/nvim-notify" },

		{
			"nvim-lualine/lualine.nvim",
			config = function()
				require("config.lualine")
			end,
		},
		{ "junegunn/limelight.vim" },
		{
			"folke/zen-mode.nvim",
			config = function()
				require("config.zen-mode")
			end,
		},
		{ "kyazdani42/nvim-web-devicons" },
		{
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				require("config.indent-blankline")
			end,
		},

		-- Tmux ---------------------------------------------------------------
		{ "tmux-plugins/vim-tmux-focus-events" },

		-- Themes -------------------------------------------------------------
		{ "rose-pine/neovim", name = "rose-pine" },
		{
			"Verf/deepwhite.nvim",
			config = function()
				require("deepwhite").setup({ low_blue_light = false })
			end,
		},
		{ "lifepillar/vim-solarized8" },
		{ "liuchengxu/space-vim-theme" },
		{ "chriskempson/vim-tomorrow-theme" },
		{ "ErichDonGubler/vim-sublime-monokai" },
		{ "yashguptaz/calvera-dark.nvim" },
		{
			"catppuccin/nvim",
			name = "catppuccin",
		},
		{
			"folke/tokyonight.nvim",
			config = function()
				require("config.tokyonight")
			end,
		},

		-- Language specific stuff
		{
			"ziglang/zig.vim",
			config = function()
				vim.g.zig_fmt_autosave = 0
			end,
		},
	},
})
