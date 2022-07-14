local nmap = require('config.utils').nmap

nmap('<leader>b', ':Telescope buffers show_all_buffers=true theme=get_dropdown<CR>')
nmap('<leader>g', ':Telescope git_files theme=get_dropdown<CR>')
nmap('<leader>f', ':Telescope find_files theme=get_dropdown<CR>')
nmap('<leader>c', ':Telescope frecency theme=get_dropdown<CR>')
nmap('<leader>r', ':Telescope live_grep theme=get_dropdown<CR>')
