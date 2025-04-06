require("conform").setup({
	save_on_format = false,
	formatters_by_ft = {
		java = { "google_java_format" },
		lua = { "stylua" },
		javascript = { "eslint_d", "prettier" },
		typescript = { "eslint_d", "prettier" },
		javascriptreact = { "eslint_d", "prettier" },
		typescriptreact = { "eslint_d", "prettier" },
	},
	formatters = {
		google_java_format = {
			command = "java",
			args = {
				"-jar",
				vim.fn.stdpath("data") .. "/mason/packages/google-java-format/google-java-format.jar",
				"-",
			},
			stdin = true,
		},
	},
})
