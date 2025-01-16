local conform = require("conform")

conform.setup({
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
		cpp = { "clang-format" },
		c = { "clang-format" },
		zig = { "zigfmt" },
	},
})

vim.api.nvim_set_keymap("n", "<leader>f", ":lua require('conform').format()<CR>", { noremap = true, silent = true })
