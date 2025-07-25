local lspconfig = require("lspconfig")

lspconfig.lemminx.setup({})

lspconfig.jdtls.setup({
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

lspconfig.lua_ls.setup({})


local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.rust_analyzer.setup({
    capabilities = capabilities,
	-- 설정 예시
	settings = {
		["rust-analyzer"] = {
			assist = {
				importEnforceGranularity = true,
				importPrefix = "by_crate",
			},
			cargo = {
				allFeatures = true,
				loadOutDirsFromCheck = true,
			},
			checkOnSave = true,
			check = {
				command = "clippy",
			},
			completion = {
				autoimport = {
					enable = true,
				},
			},
			procMacro = {
				enable = true,
			},
		},
	},
})

lspconfig.html.setup({})
