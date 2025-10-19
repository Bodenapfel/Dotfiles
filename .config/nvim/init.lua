-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.o.undofile = true
-- Map <leader>rp to open a terminal and run the current Python 3 file
vim.api.nvim_set_keymap("n", "<leader>rp", ':w<CR>:term python3 -i "%"<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<leader>rr", ':w<CR>:term cargo run "%"<CR>', { noremap = true, silent = false })
vim.keymap.set("t", "<C-[>", [[<C-\><C-n>]], { noremap = true })
