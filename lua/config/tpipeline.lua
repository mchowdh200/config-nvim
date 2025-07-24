-- get current line and column number
local function line_and_col()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local pre = "%#TpipelineGreyInv#%#TpipelineGrey#"
	local post = "%#TpipelineGreyInv#%#TpipelineGrey#"
	return pre .. " " .. row .. ":" .. col .. " " .. post
end

vim.cmd([[
let s:mode_map = {'n': 'NORMAL', 'i': 'INSERT', 'R': 'REPLACE', 'v': 'VISUAL', 'V': 'V-LINE', "\<C-v>": 'V-BLOCK', 'c': 'COMMAND', 's': 'SELECT', 'S': 'S-LINE', "\<C-s>": 'S-BLOCK', 't': 'TERMINAL'}

func MyMode()
	return tpipeline#stl#colors#modec() 
        \ . '#' 
        \ . tpipeline#stl#colors#mode()
        \ . '#'
        \ . get(s:mode_map, mode())
        \ . tpipeline#stl#colors#modec()
        \ . '#'
endfunc

func Myprogress()
	let p = tpipeline#util#percentage() * g:tpipeline_progresslen / 100
	let text = line('.') . ':' . col('.')
	let text = repeat(' ', g:tpipeline_progresslen - strchars(text) - 1) . text . ' '

	let pre = '%#TpipelineGreyInv#%#TpipelineGrey#'
	return pre . strcharpart(text, 0, p) . '%#TpipelineGreyInv#' . strcharpart(text, p)
endfunc

function! Mystatusline()
	" return tpipeline#stl#mode() 
	return MyMode()
        \ . ' ' 
        \ . tpipeline#stl#fn()
        \ . tpipeline#stl#attr()
        \ . tpipeline#stl#rec()
        \ . '%#Ignore#%='
        \ . tpipeline#stl#searchc()
        \ . tpipeline#stl#ft()
        \ . ' '
        \ . Myprogress()
endfunction
]])

vim.g.tpipeline_autoembed = 0
-- vim.g.tpipeline_statusline = "%!tpipeline#stl#mode()"
vim.g.tpipeline_statusline = "%!Mystatusline()"
-- vim.g.tpipeline_statusline = "%!tpipeline#stl#mode()"
-- 	.. " "
-- 	.. "tpipeline#stl#fn()"
-- 	.. "tpipeline#stl#attr()"
-- 	.. "tpipeline#stl#rec()"
-- 	.. "%#Ignore#%="
-- 	.. "tpipeline#stl#searchc()"
-- 	.. "tpipeline#stl#ft()"
-- 	.. " "
-- 	.. "tpipeline#stl#progress()"

-- vim.g.tpipeline_statusline = "%!tpipeline#stl#mode()"
-- 	.. " "
-- 	.. "%!tpipeline#stl#fn()"
-- 	.. " "
-- 	.. "%!tpipeline#stl#attr()"
-- 	.. " "
-- 	.. "%!tpipeline#stl#rec()"
-- 	.. "%#Ignore#%="
-- 	.. " %!tpipeline#stl#searchc()"
-- 	.. " %!tpipeline#stl#ft()"
-- .. line_and_col()

-- vim.g.tpipeline_usepane = 1
-- vim.g.tpipeline_fillcentre = 1
-- vim.g.tpipeline_restore = 1
