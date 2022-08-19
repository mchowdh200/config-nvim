local dapui = require('dapui')
dapui.setup()

vim.cmd([[
command! DapUIToggle lua require("dapui").toggle()
]])
