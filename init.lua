
require 'setup_plugins'
require 'config.mappings'


-------------------------------------------------------------------------------
-- Appearance
-------------------------------------------------------------------------------
if not vim.g.vscode then
    vim.opt.background = 'dark'
    vim.opt.termguicolors = true

    require('config.catppuccin_config')
    vim.cmd('colorscheme space_vim_theme')
    -- vim.cmd('colorscheme catppuccin-macchiato')
    -- vim.cmd('colorscheme tokyonight')

    vim.opt.guicursor:append('n-v-c:blinkon0')
    vim.api.nvim_set_hl(0, "@comment.bold", { bold = true })

end

-------------------------------------------------------------------------------
-- Editor stuff
-------------------------------------------------------------------------------

vim.cmd('autocmd FileType * set formatoptions-=o')
vim.opt.mouse = 'a'
vim.opt.updatetime = 500 -- for update latency on floating window
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.fileformat = 'unix'
vim.wo.wrap = false
vim.opt.autochdir = true
vim.opt.swapfile = false

-- configure backspace so it acts as it should
vim.opt.backspace = 'eol,start,indent'
vim.opt.whichwrap:append('<,>,h,l')
vim.opt.ruler = true
vim.opt.signcolumn = 'yes'
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.scrolloff = 4
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.clipboard = 'unnamedplus' -- linux: install xclip to work
vim.opt.autoread = true
vim.opt.splitbelow = true
vim.opt.splitright = true

-------------------------------------------------------------------------------
-- Focus mode
-------------------------------------------------------------------------------
if not vim.g.vscode then
    vim.cmd [[
        autocmd! User GoyoEnter Limelight
        autocmd! User GoyoLeave Limelight!
        let g:goyo_width=100
        let g:goyo_height=95

        let g:limelight_default_coefficient = 0.7
        let g:limelight_paragraph_span = 0
    ]]
end

-------------------------------------------------------------------------------
-- Git settings
-------------------------------------------------------------------------------
if not vim.g.vscode then
    vim.cmd [[
        command Gstatus Git
        command Gcommit Git commit
        command Gpush Git push
        command Gpull Git pull
        command Gdiff Git diff
        autocmd FileType fugitive nmap <buffer> q gq
        autocmd FileType fugitive nmap <buffer> c :Gcommit<CR>
        autocmd FileType fugitiveblame nmap <buffer> q gq
        autocmd FileType git nmap <buffer> q :q<CR>
    ]]
end

-------------------------------------------------------------------------------
-- Some language specific settings
-------------------------------------------------------------------------------
vim.api.nvim_create_autocmd('FileType', {
  pattern = { "cpp", "c", "java", },
  callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.expandtab = true
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { "cpp" },
  callback = function()
        -- set the comment string to be // 
        vim.opt_local.commentstring = "// %s"
  end
})

-------------------------------------------------------------------------------
-- Workarounds
-------------------------------------------------------------------------------
local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    notify(msg, ...)
end
