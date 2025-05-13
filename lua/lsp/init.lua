------------------------------------------------------------------------------
-- Setup language servers
------------------------------------------------------------------------------
local lspconfig = require("lspconfig")

-- This will run when an LSP attaches to buffer
local on_attach = function(client, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	local hover = function(opts)
		opts = opts or {}
		opts.border = "rounded"
		return vim.lsp.buf.hover(opts)
	end

	local signature_help = function(opts)
		opts = opts or {}
		opts.border = "rounded"
		return vim.lsp.buf.signature_help(opts)
	end

	vim.diagnostic.config({
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "",
				[vim.diagnostic.severity.WARN] = "",
				[vim.diagnostic.severity.HINT] = "",
				[vim.diagnostic.severity.INFO] = "",
			},
			texthl = {
				[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
				[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
				[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
				[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
			},
		},
	})

	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("gr", require("telescope.builtin").lsp_references)

	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	nmap("K", hover, "Hover Documentation")
	nmap("<C-k>", signature_help, "Signature Documentation")
end

-- local capabilities = require('cmp_nvim_lsp').update_capabilities(
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

------------------------------------------------------------------------------
-- Setup servers
------------------------------------------------------------------------------
lspconfig.bashls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
lspconfig.clangd.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	},
})
lspconfig.gopls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    -- settings = {
        -- gopls = {
            -- analyses = {
            --     unusedparams = true,
            --     deprecated = true,
            --     nilness = true,
            -- },
            -- staticcheck = true,
            -- usePlaceholders = true,
            -- completeUnimported = true,
            -- gofumpt = true,
        -- },
    -- },
})
lspconfig.hls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
		},
	},
	telemetry = { false },
	capabilities = capabilities,
	on_attach = on_attach,
})
lspconfig.nginx_language_server.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
lspconfig.pyright.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
lspconfig.zls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		zls = {
			-- checkOnSave = { enable = true },
			enable_build_on_save = true,
		},
	},
})
