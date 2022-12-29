local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
    sources = {
        -- null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.diagnostics.eslint,
        -- null_ls.builtins.completion.spell,
        null_ls.builtins.formatting.black.with({
            command = "black",
        }),
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.clang_format.with({
            command = "clang-format",
            args = {
                "--style",
                "{ BasedOnStyle: llvm,"..
                    "IndentWidth: 4,"..
                    "PenaltyReturnTypeOnItsOwnLine: 1000000,"..
                    "AlignAfterOpenBracket: BlockIndent,"..
                    "ExperimentalAutoDetectBinPacking: false,"..
                    "AlwaysBreakAfterDefinitionReturnType: None,"..
                    "BinPackArguments: false,"..
                    "BinPackParameters: false,"..
                    "AllowAllParametersOfDeclarationOnNextLine: false,"..
                    "ColumnLimit: 80}"
                }

            -- command = "clang-format --style='{BasedOnStyle: LLVM, IndentWidth: 4}'",
        }),
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then

            vim.cmd[[
                command! Fmt :lua vim.lsp.buf.format({timeout_ms = 5000})<CR>
            ]]
            vim.cmd[[
                nnoremap <leader>f :Fmt<CR>
            ]]

            -- vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            -- vim.api.nvim_create_autocmd("BufWritePre", {
            --     group = augroup,
            --     buffer = bufnr,
            --     callback = function()
            --         vim.lsp.buf.format({ bufnr = bufnr })
            --     end,
            -- })
        end
        -- client.server_capabilities.document_formatting = false
        -- client.server_capabilities.document_range_formatting = false
    end,
})

