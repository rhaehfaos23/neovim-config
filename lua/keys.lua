local keyset = vim.keymap.set
local builtin = require("telescope.builtin")

keyset("n", ",p", "\"0p", { silent = true, nowait = true, noremap= true });
keyset("n", ",P", "\"0P", { silent = true, nowait = true, noremap= true });

keyset("n", "<Up>", "<C-w><Up>", { silent = true, nowait = true, noremap= true });
keyset("n", "<Down>", "<C-w><Down>", { silent = true, nowait = true, noremap= true });
keyset("n", "<Left>", "<C-w><Left>", { silent = true, nowait = true, noremap= true });
keyset("n", "<Right>", "<C-w><Right>", { silent = true, nowait = true, noremap= true });

keyset("n", "<leader>ff", builtin.find_files, {})
keyset("n", "<leader>fg", builtin.live_grep, {})
keyset("n", "<leader>fb", builtin.buffers, {})
keyset("n", "<leader>fh", builtin.help_tags, {})
keyset("n", "<leader>ft", builtin.tags, {})

local vimtreeapi = require("nvim-tree.api")
keyset("n", "<leader>tt", vimtreeapi.tree.toggle, {silent = true})
keyset("n", "<leader>to", vimtreeapi.tree.open, {silent = true})
keyset("n", "<leader>tc", vimtreeapi.tree.close, {silent = true})
keyset("n", "<leader>tf", vimtreeapi.tree.focus, {silent = true})

local hop = require('hop')
local directions = require('hop.hint').HintDirection
keyset('n', 't', function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true }) end, {remap=true})
keyset('n', 'T', function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true }) end, {remap=true})
keyset('n', 's', function() hop.hint_char2({ direction = directions.AFTER_CURSOR, }) end, {remap=false})
keyset('n', 'S', function() hop.hint_char2({ direction = directions.BEFORE_CURSOR, }) end, {remap=false})
keyset('n', '<leader>/', function() hop.hint_patterns({}) end, {remap=false})
keyset('n', '<leader>hw', function() hop.hint_words({}) end, {remap=false})
keyset('n', '<leader>l', function() hop.hint_lines_skip_whitespace({}) end, {remap=false})
