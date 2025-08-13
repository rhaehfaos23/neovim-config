vim.lsp.enable("lemminx")
vim.lsp.enable("lua_ls")
vim.lsp.enable("html")

local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.config("rust_analyzer", {
	capabilities = capabilities,
	-- 설정 예시
	settings = {
		["rust-analyzer"] = {
			cargo = {
				features = "all",
			},
			checkOnSave = true,
			check = {
				command = "clippy",
			},
		},
	},
})
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("tombi")
