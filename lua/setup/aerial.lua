require("aerial").setup({
	on_attach = function(bufnr)
		vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
		vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
		vim.keymap.set("n", "<leader>ao", "<cmd>AerialOpen!<CR>")
		vim.keymap.set("n", "<leader>ac", "<cmd>AerialClose<CR>")
	end,
})
