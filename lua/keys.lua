local keyset = vim.keymap.set
local builtin = require("telescope.builtin")

keyset("n", ",p", '"0p', { silent = true, nowait = true, noremap = true })
keyset("n", ",P", '"0P', { silent = true, nowait = true, noremap = true })

keyset("n", "<Up>", "<C-w><Up>", { silent = true, nowait = true, noremap = true })
keyset("n", "<Down>", "<C-w><Down>", { silent = true, nowait = true, noremap = true })
keyset("n", "<Left>", "<C-w><Left>", { silent = true, nowait = true, noremap = true })
keyset("n", "<Right>", "<C-w><Right>", { silent = true, nowait = true, noremap = true })

keyset("n", "<leader>ff", builtin.find_files, {})
keyset("n", "<leader>fg", builtin.live_grep, {})
keyset("n", "<leader>fb", builtin.buffers, {})
keyset("n", "<leader>fh", builtin.help_tags, {})
keyset("n", "<leader>ft", builtin.tags, {})

local vimtreeapi = require("nvim-tree.api")
keyset("n", "<leader>tt", vimtreeapi.tree.toggle, { silent = true })
keyset("n", "<leader>to", vimtreeapi.tree.open, { silent = true })
keyset("n", "<leader>tc", vimtreeapi.tree.close, { silent = true })
keyset("n", "<leader>tf", vimtreeapi.tree.focus, { silent = true })

local hop = require("hop")
local directions = require("hop.hint").HintDirection
keyset("n", "t", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true })
keyset("n", "T", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true })
keyset("n", "s", function()
	hop.hint_char2({ direction = directions.AFTER_CURSOR })
end, { remap = false })
keyset("n", "S", function()
	hop.hint_char2({ direction = directions.BEFORE_CURSOR })
end, { remap = false })
keyset("n", "<leader>/", function()
	hop.hint_patterns({})
end, { remap = false })
keyset("n", "<leader>hw", function()
	hop.hint_words({})
end, { remap = false })
keyset("n", "<leader>l", function()
	hop.hint_lines_skip_whitespace({})
end, { remap = false })

-- LSP mappings
keyset("n", "gD", vim.lsp.buf.definition)
keyset("n", "K", vim.lsp.buf.hover)
keyset("n", "gi", vim.lsp.buf.implementation)
keyset("n", "gr", vim.lsp.buf.references)
keyset("n", "gds", vim.lsp.buf.document_symbol)
keyset("n", "gws", vim.lsp.buf.workspace_symbol)
keyset("n", "<leader>cl", vim.lsp.codelens.run)
keyset("n", "<leader>sh", vim.lsp.buf.signature_help)
keyset("n", "<leader>rn", vim.lsp.buf.rename)
keyset("n", "<leader>f", vim.lsp.buf.format)
keyset("n", "<leader>ca", vim.lsp.buf.code_action)

keyset("n", "<leader>ws", function()
	require("metals").hover_worksheet()
end)

-- all workspace diagnostics
keyset("n", "<leader>aa", vim.diagnostic.setqflist)

-- all workspace errors
keyset("n", "<leader>ae", function()
	vim.diagnostic.setqflist({ severity = "E" })
end)

-- all workspace warnings
keyset("n", "<leader>aw", function()
	vim.diagnostic.setqflist({ severity = "W" })
end)

-- buffer diagnostics only
keyset("n", "<leader>d", vim.diagnostic.setloclist)

keyset("n", "[c", function()
	vim.diagnostic.goto_prev({ wrap = false })
end)

keyset("n", "]c", function()
	vim.diagnostic.goto_next({ wrap = false })
end)

keyset("n", "<leader>e", function()
	vim.diagnostic.open_float(0, { scope = "line" })
end)

keyset("n", "<leader>fo", ":Format<CR>")
keyset("n", "<leader>fw", ":FormatWrite<CR>")

keyset({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
keyset({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
keyset({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
keyset({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

keyset("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
keyset("n", "<c-n>", "<Plug>(YankyNextEntry)")

keyset("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
keyset("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
keyset("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
keyset("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")

keyset("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
keyset("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
keyset("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
keyset("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

keyset("n", "=p", "<Plug>(YankyPutAfterFilter)")
keyset("n", "=P", "<Plug>(YankyPutBeforeFilter)")

keyset("n", "<leader>tyh", function()
    require("telescope").extensions.yank_history.yank_history()
end)

keyset("n", "<leader>yh", ":YankyRingHistory<CR>")
keyset("n", "<leader>yc", ":YankyClearHistory<CR>")
