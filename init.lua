local fn = vim.fn
vim.g.python3_host_prog = '~/.config/nvim/venv/bin/python'

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"linrongbin16/lsp-progress.nvim",
		config = function()
			require("lsp-progress").setup({})
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	"folke/which-key.nvim",
	"tpope/vim-repeat",
	"ggandor/leap.nvim",
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	"nvim-lualine/lualine.nvim",
	"nvim-tree/nvim-web-devicons",
	"ryanoasis/vim-devicons",
	"SirVer/ultisnips",
	"honza/vim-snippets",
	"mhinz/vim-startify",
	{ "catppuccin/nvim", name = "catppuccin" },
	"tpope/vim-surround",
	"ianks/vim-tsx",
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"lukas-reineke/indent-blankline.nvim",
	"nvim-tree/nvim-tree.lua",
	"nvim-lua/plenary.nvim",
	{ "nvim-telescope/telescope.nvim", branch = "0.1.x" },
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
	},
	"sindrets/diffview.nvim",
	{ "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },
	{ "numToStr/Comment.nvim", lazy = false },
	"editorconfig/editorconfig-vim",
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/nvim-cmp" },
		},
		opts = function(_, opts)
			local cmp_autopaires = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")

			local conf = {
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
				}),
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
				}),
			}

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
				matching = { disallow_symbol_nonprefix_matching = false },
			})

			opts.sources = opts.sources or {}
			table.insert(opts.sources, {
				name = "lazydev",
				group_index = 0, -- set group index to 0 to skip loading LuaLS completions
			})

			cmp.event:on("confirm_done", cmp_autopaires.on_confirm_done())

			return conf
		end,
	},
	{
		"mfussenegger/nvim-dap",
	},
	{
		"scalameta/nvim-metals",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"j-hui/fidget.nvim",
				opts = {},
			},
		},
		ft = { "scala", "sbt" },
		opts = function()
			local metals_config = require("metals").bare_config()

			-- Example of settings
			metals_config.settings = {
				showImplicitArguments = true,
				excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
			}

			-- *READ THIS*
			-- I *highly* recommend setting statusBarProvider to either "off" or "on"
			--
			-- "off" will enable LSP progress notifications by Metals and you'll need
			-- to ensure you have a plugin like fidget.nvim installed to handle them.
			--
			-- "on" will enable the custom Metals status extension and you *have* to have
			-- a have settings to capture this in your statusline or else you'll not see
			-- any messages from metals. There is more info in the help docs about this
			metals_config.init_options.statusBarProvider = "off"

			-- Example if you are using cmp how to make sure the correct capabilities for snippets are set
			metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

			metals_config.on_attach = function(client, bufnr)
				require("metals").setup_dap()
			end

			return metals_config
		end,
		config = function(self, metals_config)
			local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				pattern = self.ft,
				callback = function()
					require("metals").initialize_or_attach(metals_config)
				end,
				group = nvim_metals_group,
			})
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
	{ "williamboman/mason.nvim", opts = {} },
	"williamboman/mason-lspconfig.nvim",
	"mfussenegger/nvim-lint",
	{
		"gbprod/yanky.nvim",
		opts = {
			ring = {
				history_length = 100,
				storage = "shada",
				sync_with_numbered_registers = true,
				cancel_event = "update",
				ignore_registers = { "_" },
				update_register_on_cycle = false,
			},
			picker = {
				select = {
					action = nil, -- nil to use default put action
				},
				telescope = {
					use_default_mappings = true, -- if default mappings should be used
					mappings = nil, -- nil to use default mappings or no mappings (see `use_default_mappings`)
				},
			},
			system_clipboard = {
				sync_with_ring = true,
				clipboard_register = nil,
			},
			highlight = {
				on_put = true,
				on_yank = true,
				timer = 500,
			},
			preserve_cursor_position = {
				enabled = true,
			},
			textobj = {
				enabled = true,
			},
		},
	},
	{ "echasnovski/mini.icons", version = false },
	{
		"stevearc/conform.nvim",
		opts = {},
	},
	{
		"stevearc/aerial.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
})

require("setup/telescope")
require("setup/catppuccin")
require("setup/nvim-treesitter")
require("setup/nvim-tree")
require("setup/lualine")
require("setup/nvim-web-devicons")
require("setup/bufferline")
require("setup/comment_nvim")
require("setup/typescript_tools")
require("setup/nvim_lint")
require("setup/nvim-dap")
require("setup/lsp-config")
require("setup/conform")
require("setup/leap")
require("setup/aerial")

require("globals")
require("keys")

-- setup must be called before loading
vim.cmd.colorscheme("catppuccin-mocha") -- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha

vim.opt.termguicolors = true

vim.api.nvim_command("syntax on")
vim.api.nvim_command("set nowrap")
vim.api.nvim_command("set nocompatible")
vim.api.nvim_command("set number")
vim.api.nvim_command("set showmatch")
vim.api.nvim_command("set ignorecase")
vim.api.nvim_command("set hlsearch")
vim.api.nvim_command("set incsearch")
vim.api.nvim_command("set tabstop=4")
vim.api.nvim_command("set softtabstop=4")
vim.api.nvim_command("set expandtab")
vim.api.nvim_command("set shiftwidth=4")
vim.api.nvim_command("set autoindent")
vim.api.nvim_command("set wildmode=longest,list")
vim.api.nvim_command("set cc=150")
vim.api.nvim_command("set mouse=a")
vim.api.nvim_command("set clipboard+=unnamedplus")
vim.api.nvim_command("set cursorline")
vim.api.nvim_command("set ttyfast")
vim.api.nvim_command("set tags=tags")
vim.api.nvim_command("filetype plugin indent on")
vim.api.nvim_command("set hidden")
vim.api.nvim_command("set cmdheight=2")
vim.api.nvim_command("set noswapfile")

-- Don't pass messages to |ins-completion-menu|.
vim.api.nvim_command("set shortmess+=c")

-- coc.vim config start
-- Some servers have issues with backup files, see #649
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 750

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = "yes"

-- Autocomplete
function _G.check_back_space()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

-- vim-startify no chagne directory
vim.g.startify_change_to_dir = 0

vim.api.nvim_create_autocmd({ "BufWritePost", "FileWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})

local rust_augroup = vim.api.nvim_create_augroup("RustConfig", { clear = true })

vim.api.nvim_create_autocmd("BufRead", {
	group = rust_augroup,
	pattern = "*.rs",
	callback = function()
		local rust_src_path = os.getenv("RUST_SRC_PATH")

		local tags_value = "./rusty-tags.vi;/"
		if rust_src_path and vim.fn.isdirectory(rust_src_path) == 1 then
			tags_value = tags_value .. "," .. rust_src_path .. "/rusty-tags.vi"
		end

		vim.bo.tags = tags_value
	end,
})

local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)
