local ok, catppuccin = pcall(require, "catppuccin")
if not ok then
	return
end

catppuccin.setup({
	transparent_background = false,
	term_colors = false,
    compile = {
        enabled = true,
        path = vim.fn.stdpath "cache" .. "/catppuccin",
        suffix = "_compiled"
    },
	styles = {
		comments = { "italic" },
		conditionals = { "bold" },
		loops = { "bold" },
		functions = { "bold" },
		keywords = { "bold" },
		strings = {},
		variables = {},
		numbers = {},
		types = { "bold" },
		operators = {},
	},
	integrations = {
		treesitter = true,
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			}
		},
		lsp_trouble = false,
		cmp = true,
		lsp_saga = true,
		gitgutter = false,
		gitsigns = true,
		telescope = true,
		nvimtree = {
			enabled = true,
			show_root = false,
		},
		which_key = false,
		indent_blankline = {
			enabled = true,
			colored_indent_levels = false,
		},
		dashboard = true,
		neogit = false,
		vim_sneak = false,
		fern = false,
		barbar = false,
		bufferline = true,
		markdown = true,
		lightspeed = false,
		ts_rainbow = false,
		hop = true,
		notify = true,
	},
})
