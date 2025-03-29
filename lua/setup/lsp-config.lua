-- lua관련 셋팅
require("lspconfig").lemminx.setup({})

-- java관련 셋팅
require('lspconfig').jdtls.setup({
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = "JavaSE-21",
            path = "/home/junhui/Tools/jdk-21.0.6+7",
            default = true,
          }
        }
      }
    }
  }
})
