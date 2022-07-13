-------------------------------------------------------------------------------
-- Helper functions for configuring neovim
-------------------------------------------------------------------------------
local utils = {}
utils.map = function(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, {noremap = true})
end

utils.nmap = function(shortcut, command)
  utils.map('n', shortcut, command)
end

utils.imap = function(shortcut, command)
  utils.map('i', shortcut, command)
end

utils.vmap = function(shortcut, command)
  utils.map('v', shortcut, command)
end
return utils
