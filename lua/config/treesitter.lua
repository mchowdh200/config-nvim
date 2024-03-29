local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = "all", -- one of "all" or a list of languages
	ignore_install = { "orgmode" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "css" }, -- list of language that will be disabled
	},
	autopairs = {
		enable = true,
	},
	indent = {
        enable = true,
        disable = {
            "css",
            "python", -- broken at the moment
        }
    },
})



-- vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
-- vim.cmd[[autocmd BufWinEnter * silent! :%foldopen!]]





