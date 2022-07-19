local nmap = require('config.utils').nmap

nmap('<leader>b', ':Telescope buffers show_all_buffers=true theme=get_dropdown<CR>')
nmap('<leader>gf', ':Telescope git_files theme=get_dropdown<CR>')
nmap('<leader>f', ':Telescope find_files theme=get_dropdown<CR>')
nmap('<leader>c', ':Telescope frecency theme=get_dropdown<CR>')
nmap('<leader>r', ':Telescope lsp_references theme=get_dropdown<CR>')
nmap('<leader>gg', ':Telescope live_grep theme=get_dropdown<CR>')
nmap('<leader>s', ':Telescope lsp_dynamic_workspace_symbols theme=get_dropdown<CR>')
