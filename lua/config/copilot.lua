vim.cmd([[
    let g:copilot_filetypes = {
        \ 'dockerfile': v:true,
        \ 'yaml': v:true,
   \}
]])

vim.keymap.set("i", "<C-L>", "<Plug>(copilot-accept-word)")

vim.g.copilot_settings = { selectedCompletionModel = "gpt-4o-copilot" }
vim.g.copilot_integration_id = "vscode-chat"
