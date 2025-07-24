local map = function(mode, shortcut, command)
	vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true })
end

local nmap = function(shortcut, command)
	map("n", shortcut, command)
end

local imap = function(shortcut, command)
	map("i", shortcut, command)
end

local vmap = function(shortcut, command)
	map("v", shortcut, command)
end

local tmap = function(shortcut, command)
	map("t", shortcut, command)
end

-- vim.api.nvim_create_user_command("ToggleBackground", function()
--     vim.cmd('set background=' .. (vim.o.background == 'dark' and 'light' or 'dark'))
-- end, {range = false, nargs = 0})

-- basic remaps
nmap("<space>", ":")
-- nmap('<up>', '<c-p>') -- arrow keys for completions navigation
-- nmap('<down>', '<c-n>')
if not vim.g.vscode then
	imap("jk", "<Esc>")
	tmap("jk", "<C-\\><C-n>")
	nmap("\\", ":pclose<CR>") -- close popup

	-- leader maps
	vim.g.mapleader = ","
	vim.g.maplocalleader = "\\"
	nmap("<leader>h", "<C-W><C-H>")
	nmap("<leader>j", "<C-W><C-J>")
	nmap("<leader>k", "<C-W><C-K>")
	nmap("<leader>l", "<C-W><C-L>")
	nmap("<leader>n", ":set invnumber<CR>")
	nmap("<leader>\\", ":noh<CR>")
	nmap("<leader>d", ":ToggleBackground<CR>")

	nmap("q", ":silent! normal za<CR>:echo ''<CR>") -- toggle folding

	-- if zen-mode installed
	ok, _ = pcall(require, "zen-mode")
	if ok then
		nmap("<leader>z", ":ZenMode<CR>")
	end

	vim.cmd([[
    autocmd FileType tex nnoremap <buffer> <F5> :w<CR>:!pdflatex %<CR>
    ]])
end

-- autocommand to remap j/k (and other relevant motions),
-- to gj/gk, etc in markdown files
-- in order to be able to move across wrapped lines
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.api.nvim_buf_set_keymap(0, "n", "j", "gj", { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(0, "n", "k", "gk", { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(0, "v", "j", "gj", { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(0, "v", "k", "gk", { noremap = true, silent = true })

		vim.api.nvim_buf_set_keymap(0, "n", "$", "g$", { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(0, "n", "0", "g0", { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(0, "v", "$", "g$", { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(0, "v", "0", "g0", { noremap = true, silent = true })

		-- nmap("j", "gj")
		-- nmap("k", "gk")
		-- vmap("j", "gj")
		-- vmap("k", "gk")

		-- nmap("$", "g$")
		-- nmap("0", "g0")
		-- vmap("$", "g$")
		-- vmap("0", "g0")
	end,
})

-- ok, _ = pcall(require, 'copilot')
-- if ok then
--     vim.cmd[[
--         imap <silent><script><expr> <S-Tab> copilot#Accept("\<CR>")
--     ]]
-- end
