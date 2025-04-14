local conform = require("conform")

conform.setup({
	-- lsp_format = "never",
	formatters_by_ft = {
		python = { "black", "isort" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		svelte = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		graphql = { "prettier" },
		lua = { "stylua" },
		cpp = { "clang_format" },
		c = { "clang_format" },
		zig = { "zigfmt" },
		snakemake = { "snakefmt" },
		rust = { "rustfmt" },
	},
})

conform.formatters.clang_format = {
	command = "clang-format",
	append_args = function()
		return {
			"--style=file:" .. vim.fn.expand("~/.config/nvim/lua/config/clang_format.yaml"),
		}
	end,
}

vim.api.nvim_set_keymap(
	"n",
	"<leader>f",
	":lua require('conform').format({ async=true })<CR>",
	{ noremap = true, silent = true }
)
