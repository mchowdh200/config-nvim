local indent_blankline = require("ibl")
indent_blankline.setup {
    -- show_current_context = false,
    -- show_current_context_start = false,
    -- enabled = true,
    -- use_treesitter = true,
    whitespace = {
        remove_blankline_trail = false,
    },
    scope = {
        enabled = true,
        show_start = false,
        show_end = false,
    },
}

