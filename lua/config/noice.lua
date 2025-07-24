require("noice").setup({
	cmdline = {
		enabled = true, -- enables the Noice cmdline UI
		view = "cmdline",
	},
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		-- override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
		-- },
		signature = {
			enabled = false,
			-- auto_open = {
			-- enabled = false,
			-- trigger = true, -- This will open signature help automatically
			-- timer = 1000, -- The time in milliseconds to wait before opening
			-- },
		},
	},
	-- you can enable a preset for easier configuration
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = true, -- add a border to hover docs and signature help
	},
})

require("notify").setup({
	timeout = 3000,
	stages = "static",
})
