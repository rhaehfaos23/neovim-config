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
keyset("n", "<leader>to", vimtreeapi.tree.open, { silent = true })
keyset("n", "<leader>tc", vimtreeapi.tree.close, { silent = true })
keyset("n", "<leader>tf", vimtreeapi.tree.focus, { silent = true })

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

keyset({ "n", "v" }, "<leader>f", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file or range" })

keyset("n", "<leader>ca", vim.lsp.buf.code_action)

keyset("n", "<leader>ws", function()
	require("metals").hover_worksheet()
end)

-- all workspace diagnostics
keyset("n", "<leader>aa", vim.diagnostic.setqflist)

-- all workspace errors
keyset("n", "<leader>ae", function()
	vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
end)

-- all workspace warnings
keyset("n", "<leader>aw", function()
	vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.WARN })
end)

-- buffer diagnostics only
keyset("n", "<leader>d", vim.diagnostic.setloclist)

keyset("n", "[c", function()
	vim.diagnostic.jump({ count = -1, float = true })
end)

keyset("n", "]c", function()
	vim.diagnostic.jump({ count = 1, float = true })
end)

keyset("n", "<leader>e", function()
	vim.diagnostic.open_float({ bufnr = 0, scope = "line" })
end)

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

local dap = require("dap")

keyset("n", "<leader>dr", function()
	dap.repl.toggle()
end)
keyset("n", "<leader>dK", function()
	require("dap.ui.widgets").hover()
end)

keyset("n", "<leader>dl", function()
	dap.run_last()
end)

keyset("n", "<leader>dso", function()
	dap.step_over()
end)

keyset("n", "<leader>dsi", function()
	dap.step_into()
end)

keyset("n", "<F12>", function()
	dap.step_out()
end)

keyset("n", "<leader>b", function()
	dap.toggle_breakpoint()
end)

keyset("n", "<leader>dc", function()
	dap.continue()
end)

keyset("n", "<F2>", ":set paste!<CR>", { silent = true, noremap = true })
