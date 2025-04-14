-- change some of the colors to be more readable
require("tokyonight").setup({
	styles = {
		functions = { bold = true },
		keywords = { bold = true },
		-- variables = { italic = true },
		conditionals = { bold = true, italic = false },
		loops = { bold = true, italic = false },
		comments = { italic = true },
	},
	on_highlights = function(hl, c)
		hl.DiagnosticUnderlineWarn.undercurl = false
		hl.DiagnosticUnderlineWarn.underline = true

		hl.DiagnosticUnderlineError.undercurl = false
		hl.DiagnosticUnderlineError.underline = true

		hl.DiagnosticUnderlineHint.undercurl = false
		hl.DiagnosticUnderlineHint.underline = true

		hl.DiagnosticUnderlineInfo.undercurl = false
		hl.DiagnosticUnderlineInfo.underline = true

		hl.SpellBad.undercurl = false
		hl.SpellBad.underline = true

		hl.SpellCap.undercurl = false
		hl.SpellCap.underline = true

		hl.SpellLocal.undercurl = false
		hl.SpellLocal.underline = true

		hl.SpellRare.undercurl = false
		hl.SpellRare.underline = true
	end,
})

-- example
-- comments = { "italic" },
-- conditionals = { "italic" },
-- loops = {},
-- functions = {},
-- keywords = {},
-- strings = {},
-- variables = {},
-- numbers = {},
-- booleans = {},
-- properties = {},
-- types = {},
-- operators = {},
