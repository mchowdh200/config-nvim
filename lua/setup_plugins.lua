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
				"hrsh7th/nvim-cmp",
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
			"stevearc/conform.nvim",
			event = { "BufReadPre", "BufNewFile" },
			config = function()
				require("config.conform")
			end,
		},
		{
			"rachartier/tiny-inline-diagnostic.nvim",
			event = "VeryLazy", -- Or `LspAttach`
			priority = 1000, -- needs to be loaded in first
			config = function()
				require("tiny-inline-diagnostic").setup({
					signs = {
						left = "",
						right = "",
					},
					blend = {
						factor = 0.22,
					},
				})
				vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
			end,
		},

		-- cmp ----------------------------------------------------------------
		{
			"hrsh7th/nvim-cmp",
			lazy = true,
			config = function()
				require("completions")
			end,
		},
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-nvim-lsp-signature-help" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-cmdline" },

		-- {
		-- 	"saghen/blink.cmp",
		-- 	version = "1.*",
		-- 	config = function()
		-- 		require("completions")
		-- 	end,
		-- },

		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		},

		-- {
		-- 	"github/copilot.vim",
		-- 	config = function()
		-- 		require("config.copilot")
		-- 	end,
		-- },
		{
			"olimorris/codecompanion.nvim",
			config = function()
				require("config.codecompanion")
			end,
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter",
			},
		},
		{
			"ggml-org/llama.vim",
			init = function()
				vim.g.llama_config = {
					show_info = 0,
					keymap_accept_word = "<C-L>",
					stop_strings = { "\n" },
				}
				local comment_hl = vim.api.nvim_get_hl(0, { name = "Comment" })
				vim.api.nvim_set_hl(0, "llama_hl_hint", {
					fg = comment_hl.fg,
					bg = comment_hl.bg,
				})
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
		{
			"folke/noice.nvim",
			event = "VeryLazy",
			config = function()
				require("config.noice")
			end,
			dependencies = {
				-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
				"MunifTanjim/nui.nvim",
				-- OPTIONAL:
				--   `nvim-notify` is only needed, if you want to use the notification view.
				--   If not available, we use `mini` as the fallback
				"rcarriga/nvim-notify",
				"hrsh7th/nvim-cmp",
			},
		},
		{
			"epwalsh/obsidian.nvim",
			version = "*",
			lazy = true,
			ft = "markdown",
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				require("config.obsidian")
			end,
		},
		{
			"nvim-lualine/lualine.nvim",
			enabled = function()
				-- only load if not in tmux
				return vim.env.TMUX == nil
			end,

			config = function()
				require("config.lualine")
				-- Avoid duplicate lualine on changing colorscheme
				local lualine_nvim_opts = require("lualine.utils.nvim_opts")
				local base_set = lualine_nvim_opts.set

				lualine_nvim_opts.set = function(name, val, scope)
					if vim.env.TMUX ~= nil and name == "statusline" then
						if scope and scope.window == vim.api.nvim_get_current_win() then
							vim.g.tpipeline_statusline = val
							vim.cmd("silent! call tpipeline#update()")
						end
						return
					end
					return base_set(name, val, scope)
				end
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
		{
			"vimpostor/vim-tpipeline",
			lazy = false,
			config = function()
				require("config.tpipeline")
			end,
		},

		-- Themes -------------------------------------------------------------
		{
			"maxmx03/solarized.nvim",
			config = function()
				require("config.solarized")
			end,
		},
		{ "rose-pine/neovim", name = "rose-pine" },
		{
			"Verf/deepwhite.nvim",
			config = function()
				require("deepwhite").setup({ low_blue_light = false })
			end,
		},
		-- { "lifepillar/vim-solarized8" },
		-- { "liuchengxu/space-vim-theme" },
		-- { "chriskempson/vim-tomorrow-theme" },
		-- { "ErichDonGubler/vim-sublime-monokai" },
		-- { "yashguptaz/calvera-dark.nvim" },
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

		-- Jupyter notebooks in neovim
		-- {
		-- 	"benlubas/molten-nvim",
		-- 	version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
		-- 	dependencies = {
		-- 		"3rd/image.nvim",
		-- 		"quarto-dev/quarto-nvim",
		-- 		"jmbuhr/otter.nvim",
		-- 		"GCBallesteros/jupytext.nvim",
		-- 	},
		-- 	build = ":UpdateRemotePlugins",
		-- 	init = function()
		-- 		-- these are examples, not defaults. Please see the readme
		-- 		vim.g.molten_image_provider = "image.nvim"
		-- 		vim.g.molten_output_win_max_height = 20
		-- 		vim.g.molten_auto_open_output = false
		-- 		vim.g.molten_wrap_output = true
		-- 		vim.g.molten_virt_text_output = true
		-- 		vim.g.molten_virt_lines_off_by_1 = true
		-- 	end,
		-- 	config = function()
		-- 		require("config.quarto")
		-- 		require("jupytext").setup({
		-- 			style = "markdown",
		-- 			output_extension = "md",
		-- 			force_ft = "markdown",
		-- 		})
		-- 		require("config.molten")
		-- 	end,
		-- },
		-- {
		-- 	-- see the image.nvim readme for more information about configuring this plugin
		-- 	"3rd/image.nvim",
		-- 	opts = {
		-- 		backend = "kitty", -- whatever backend you would like to use
		-- 		max_width = 100,
		-- 		max_height = 12,
		-- 		max_height_window_percentage = math.huge,
		-- 		max_width_window_percentage = math.huge,
		-- 		window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
		-- 		window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
		-- 	},
		-- },
		-- {
		-- 	"lukas-reineke/headlines.nvim",
		-- 	dependencies = "nvim-treesitter/nvim-treesitter",
		-- 	config = true, -- or `opts = {}`
		-- },
	},
})
