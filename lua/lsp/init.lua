------------------------------------------------------------------------------
-- Setup language servers
------------------------------------------------------------------------------
local lspconfig = require('lspconfig')
require("nvim-lsp-installer").setup()

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end


-- This will run when an LSP attaches to buffer
local on_attach = function(client, bufnr)


    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set( 'n', keys, func,
            { buffer = bufnr, desc = desc }
        )
    end

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('gr', require('telescope.builtin').lsp_references)

    nmap('<leader>ds',
        require('telescope.builtin').lsp_document_symbols,
        '[D]ocument [S]ymbols')
    nmap('<leader>ws',
        require('telescope.builtin').lsp_dynamic_workspace_symbols,
        '[W]orkspace [S]ymbols')

    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
end

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = "rounded", }
)

local capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities())
lspconfig.pyright.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}
lspconfig.bashls.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
lspconfig.sumneko_lua.setup{
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
            },
        },
    },
    telemetry = { false },
    capabilities = capabilities,
    on_attach = on_attach,
}
