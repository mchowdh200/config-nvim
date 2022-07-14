local cmp = require('cmp')
local lspconfig = require('lspconfig')

-- TODO look up these options and decide for myself
vim.opt.completeopt = 'menu,menuone,noselect'

-- General cmp settings ------------------------------------------------------
cmp.setup({
    snippet = {}, -- TODO
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        -- scoll documentation of a completion
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),

        -- If the completion menu is visible, move to the next item.
        -- If the line is "empty", insert a Tab character.
        -- If the cursor is inside a word, trigger the completion menu.
        ['<Tab>'] = cmp.mapping(function(fallback)
            local col = vim.fn.col('.') - 1

            if cmp.visible() then
                cmp.select_next_item(select_opts)
            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                fallback()
            else
                cmp.complete()
            end
        end, {'i', 's'}),

        -- If the completion menu is visible, move to the previous item.
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item(select_opts)
            else
                fallback()
            end
        end, {'i', 's'}),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },

    })
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(), -- what's this value
    sources = {{ name = 'cmdline' }}
})

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {{ name = 'buffer' }}
})



-- Customize diagnostics -----------------------------------------------------

-- TODO incorporate this into on_attach function
-- open float window when cursor is hovering above point
vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
        local opts = {
            focusable = false,
            close_events = {
                "BufLeave", "CursorMoved", 
                "InsertEnter", "FocusLost"
            },
            border = 'single',
            source = 'always',
            prefix = ' ',
            header = ' ',
            scope = 'cursor',
        }
        vim.diagnostic.open_float(nil, opts)
    end
})

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = false,
    update_in_insert = false,
    severity_sort = true,
})



-- Setup language servers ----------------------------------------------------
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
lspconfig.pyright.setup {
    capabilities = capabilities
}
lspconfig.bashls.setup{
    capabilities = capabilities
}

