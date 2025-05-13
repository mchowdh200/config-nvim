require("setup_plugins")
require("config.mappings")

-------------------------------------------------------------------------------
-- Appearance
-------------------------------------------------------------------------------
local dark_theme = "tokyonight-storm"
local light_theme = "tokyonight-day"
-- local dark_theme = "catppuccin-mocha"
-- local light_theme = "catppuccin-latte"
vim.api.nvim_create_user_command("ToggleColorscheme", function()
	vim.cmd("set background=" .. (vim.o.background == "dark" and "light" or "dark"))
	vim.cmd("colorscheme " .. (vim.o.background == "light" and light_theme or dark_theme))
end, { range = false, nargs = 0 })
vim.api.nvim_set_keymap("n", "<leader>d", ":ToggleColorscheme<CR>", { noremap = true, silent = true })

require("config.catppuccin_config")
if vim.opt.background == "light" then
	vim.cmd("colorscheme " .. light_theme)
else
	vim.cmd("colorscheme " .. dark_theme)
end

vim.opt.guicursor:append("n-v-c:blinkon0")

-------------------------------------------------------------------------------
-- Editor stuff
-------------------------------------------------------------------------------

vim.cmd("autocmd FileType * set formatoptions-=o")
vim.opt.mouse = "a"
vim.opt.updatetime = 500 -- for update latency on floating window
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.fileformat = "unix"
vim.wo.wrap = false
-- Enable word wrap for Markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})
vim.opt.autochdir = true
vim.opt.swapfile = false

-- configure backspace so it acts as it should
vim.opt.backspace = "eol,start,indent"
vim.opt.whichwrap:append("<,>,h,l")
vim.opt.ruler = true
vim.opt.signcolumn = "yes"
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.scrolloff = 4
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.conceallevel = 2

-- vim.g.clipboard = {
-- 	name = "OSC 52",
-- 	copy = {
-- 		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
-- 		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
-- 	},
-- 	paste = {
-- 		["+"] = require("vim.ui.clipboard.osc52").paste("+"),
-- 		["*"] = require("vim.ui.clipboard.osc52").paste("*"),
-- 	},
-- }
vim.opt.clipboard = "unnamedplus" -- linux: install xclip to work

vim.opt.autoread = true
vim.opt.splitbelow = true
vim.opt.splitright = true

-------------------------------------------------------------------------------
-- Focus mode
-------------------------------------------------------------------------------
if not vim.g.vscode then
	vim.cmd([[
        autocmd! User GoyoEnter Limelight
        autocmd! User GoyoLeave Limelight!
        let g:goyo_width=100
        let g:goyo_height=95

        let g:limelight_default_coefficient = 0.7
        let g:limelight_paragraph_span = 0
    ]])
end

-------------------------------------------------------------------------------
-- Git settings
-------------------------------------------------------------------------------
vim.cmd([[
    command Gstatus Git
    command Gcommit Git commit
    command Gpush Git push
    command Gpull Git pull
    command Gdiff Git diff
    autocmd FileType fugitive nmap <buffer> q gq
    autocmd FileType fugitive nmap <buffer> c :Gcommit<CR>
    autocmd FileType fugitiveblame nmap <buffer> q gq
    autocmd FileType git nmap <buffer> q :q<CR>
]])

-------------------------------------------------------------------------------
-- Some language specific settings
-------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "cpp", "c", "java" },
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.expandtab = true
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "cpp" },
	callback = function()
		-- set the comment string to be //
		vim.opt_local.commentstring = "// %s"
	end,
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
