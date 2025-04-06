require("lspconfig").lemminx.setup({})

require("lspconfig").jdtls.setup({
	settings = {
		java = {
			configuration = {
				runtimes = {
					{
						name = "JavaSE-21",
						path = "/home/junhui/Tools/jdk-21.0.6+7",
						default = true,
					},
				},
			},
		},
	},
})

require("lspconfig").lua_ls.setup({})
