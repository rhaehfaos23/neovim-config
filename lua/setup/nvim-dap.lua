-- Debug settings if you're using nvim-dap
local dap = require("dap")

dap.configurations.scala = {
	{
		type = "scala",
		request = "launch",
		name = "RunOrTest",
		metals = {
			runType = "runOrTestFile",
			--args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
		},
	},
	{
		type = "scala",
		request = "launch",
		name = "Test Target",
		metals = {
			runType = "testTarget",
		},
	},
}

dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = {
		os.getenv("HOME") .. "/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js",
	},
}

dap.configurations.javascript = {
	{
		name = "Launch",
		type = "node2",
		request = "launch",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
	},
	{
		name = "Attach to process",
		type = "node2",
		request = "attach",
		processId = require("dap.utils").pick_process,
	},
}

dap.configurations.typescript = {
	{
		name = "Launch",
		type = "node2",
		request = "launch",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
		outFiles = { "${workspaceFolder}/dist/**/*.js" },
	},
	{
		name = "Attach to process",
		type = "node2",
		request = "attach",
		processId = require("dap.utils").pick_process,
	},
}


-- 1) CodeLLDB 어댑터 설정
dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- Mason 등을 통해 설치한 CodeLLDB 경로를 적어줍니다
    -- Mason 설치 경로 예시: ~/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb
    command = "/home/junhui/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb",
    args = { "--port", "${port}" }
  }
}

-- 2) Rust 전용 Debug 설정 (dap.configurations.rust)
dap.configurations.rust = {
  {
    name = "Debug binary",
    type = "codelldb",
    request = "launch",
    program = function()
      -- 디버깅할 실행 파일 경로 지정 (빌드 산출물)
      -- 보통은 'cargo build' 후 target/debug/프로그램명 을 지정하거나,
      -- 아래처럼 FZF 등으로 선택하게 할 수도 있습니다.
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    showDisassembly = "never"
  },
}
