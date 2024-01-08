
-- vim.cmd [[let g:copilot_filetypes = {'dockerfile': v:true,
--                                     \ 'yaml': v:true,}]]
vim.cmd([[
    let g:copilot_filetypes = {
        \ 'dockerfile': v:true,
        \ 'yaml': v:true,
   \}
]])


vim.keymap.set('i', '<C-L>', '<Plug>(copilot-accept-word)')
