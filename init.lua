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
	"preservim/nerdcommenter",
	"mhinz/vim-startify",
	{ "neoclide/coc.nvim", branch = "release" },
	{ "catppuccin/nvim", name = "catppuccin" },
	"tpope/vim-surround",
	"ianks/vim-tsx",
	"leafgarland/typescript-vim",
	"github/copilot.vim",
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
	"lukas-reineke/indent-blankline.nvim",
	"nvim-tree/nvim-tree.lua",
	"phaazon/hop.nvim",
	"nvim-lua/plenary.nvim",
	{ "nvim-telescope/telescope.nvim", tag = "0.1.1" },
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	"sindrets/diffview.nvim",
	"windwp/nvim-autopairs",
    {"akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons"}
})

require("setup/telescope")
require("setup/catppuccin")
require("setup/nvim-treesitter")
require("setup/nvim-tree")
require("setup/lualine")
require("setup/nvim-web-devicons")
require("setup/hop")
require("setup/nvim-autopairs")
require("setup/bufferline")

require("globals")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

vim.keymap.set("i", "<CR>", "v:lua.MUtils.completion_confirm()", {expr = true , noremap = true})

local vimtreeapi = require("nvim-tree.api")
vim.keymap.set("n", "<leader>t", vimtreeapi.tree.toggle, {silent = true})
vim.keymap.set("n", "<leader>ft", vimtreeapi.tree.focus, {silent = true})

local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('n', 't', function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true }) end, {remap=true})
vim.keymap.set('n', 'T', function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true }) end, {remap=true})
vim.keymap.set('n', 's', function() hop.hint_char2({ direction = directions.AFTER_CURSOR, }) end, {remap=false})
vim.keymap.set('n', 'S', function() hop.hint_char2({ direction = directions.BEFORE_CURSOR, }) end, {remap=false})
-- vim.keymap.set('n', '<leader>s', function() hop.hint_char2({}) end, {remap=false})
vim.keymap.set('n', '<leader>/', function() hop.hint_patterns({}) end, {remap=false})
vim.keymap.set('n', '<leader>hw', function() hop.hint_words({}) end, {remap=false})
vim.keymap.set('n', '<leader>l', function() hop.hint_lines_skip_whitespace({}) end, {remap=false})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"

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
vim.api.nvim_command("set cc=120")          
vim.api.nvim_command("set mouse=a")
vim.api.nvim_command("set clipboard=unnamedplus")
vim.api.nvim_command("set cursorline")
vim.api.nvim_command("set ttyfast")           
vim.api.nvim_command("set tags=tags")
vim.api.nvim_command("filetype plugin indent on")
vim.api.nvim_command("set hidden")
vim.api.nvim_command("set nobackup")
vim.api.nvim_command("set nowritebackup")
vim.api.nvim_command("set cmdheight=2")

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.api.nvim_command("set updatetime=300")

-- Don't pass messages to |ins-completion-menu|.
vim.api.nvim_command("set shortmess+=c")

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
if vim.fn.has("patch-8.1.1564") == 1 then
-- Recently vim can merge signcolumn and number column into one
	vim.api.nvim_command("set signcolumn=number")
else
	vim.api.nvim_command("set signcolumn=yes")
end


vim.api.nvim_create_autocmd({"BufEnter", "BufRead"},{
    pattern = {"*.ts", "*.js", "*.tsx", "*.jsx", "*.html"},
    callback = function(ev) 
        vim.api.nvim_command("setlocal ts=2 sw=2")
    end
})


local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)
