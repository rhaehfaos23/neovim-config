local map = vim.keymap.set
local fn = vim.fn

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
	"folke/which-key.nvim",
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	"folke/neodev.nvim",
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
	"phaazon/hop.nvim",
	"nvim-lua/plenary.nvim",
	{ "nvim-telescope/telescope.nvim", branch = "0.1.x" },
	{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },
	"sindrets/diffview.nvim",
	{ "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },
	{ "numToStr/Comment.nvim", lazy = false },
	"editorconfig/editorconfig-vim",
	"jiangmiao/auto-pairs",
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-vsnip" },
			{ "hrsh7th/vim-vsnip" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/nvim-cmp" },
		},
		opts = function()
			local cmp = require("cmp")
			local conf = {
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "vsnip" },
				}, {
					{ name = "buffer" },
				}),
				snippet = {
					expand = function(args)
						-- Comes from vsnip
						fn["vsnip#anonymous"](args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					-- None of this made sense to me when first looking into this since there
					-- is no vim docs, but you can't have select = true here _unless_ you are
					-- also using the snippet stuff. So keep in mind that if you remove
					-- snippets you need to remove this select
					["<CR>"] = cmp.mapping.confirm({ select = true }),
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
		ft = { "scala", "sbt", "java" },
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
	"mfussenegger/nvim-lint",
	"mhartington/formatter.nvim",
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
    { 'echasnovski/mini.icons', version = false },
})

require("setup/telescope")
require("setup/catppuccin")
require("setup/nvim-treesitter")
require("setup/nvim-tree")
require("setup/lualine")
require("setup/nvim-web-devicons")
require("setup/hop")
require("setup/bufferline")
require("setup/comment_nvim")
require("setup/typescript_tools")
require("setup/typescript_tools")
require("setup/formatter")
require("setup/nvim_lint")
require("setup/nvim-dap")
require("setup/lsp-config")

require("globals")
require("keys")
local themes = require("telescope.themes")

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
vim.api.nvim_command("set tags=tags")

-- Don't pass messages to |ins-completion-menu|.
vim.api.nvim_command("set shortmess+=c")

-- coc.vim config start
-- Some servers have issues with backup files, see #649
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = "yes"

local keyset = vim.keymap.set

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

local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)
