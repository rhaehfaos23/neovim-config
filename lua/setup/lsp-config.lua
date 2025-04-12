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

lspconfig.rust_analyzer.setup({
  -- 설정 예시
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importEnforceGranularity = true,
        importPrefix = "by_crate",
      },
      cargo = {
        allFeatures = true,
      },
      -- rust-analyzer가 자동으로 검사(compile check) 시 clippy 사용
      checkOnSave = {
        command = "clippy",
      },
    }
  }
})
