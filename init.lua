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
	{ "neoclide/coc.nvim", branch = "release" },
	{ "catppuccin/nvim", name = "catppuccin" },
	"tpope/vim-surround",
	"ianks/vim-tsx",
	"leafgarland/typescript-vim",
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
	"lukas-reineke/indent-blankline.nvim",
	"nvim-tree/nvim-tree.lua",
	"phaazon/hop.nvim",
	"nvim-lua/plenary.nvim",
	{ "nvim-telescope/telescope.nvim", tag = "0.1.2" },
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	"sindrets/diffview.nvim",
    { "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },
	{ "numToStr/Comment.nvim", lazy=false },
	'editorconfig/editorconfig-vim',
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

require("globals")

local builtin = require("telescope.builtin")
local themes = require("telescope.themes")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>ft", builtin.tags, {})


vim.keymap.set("i", "<CR>", "v:lua.MUtils.completion_confirm()", {expr = true , noremap = true})

local vimtreeapi = require("nvim-tree.api")
vim.keymap.set("n", "<leader>tt", vimtreeapi.tree.toggle, {silent = true})
vim.keymap.set("n", "<leader>to", vimtreeapi.tree.open, {silent = true})
vim.keymap.set("n", "<leader>tc", vimtreeapi.tree.close, {silent = true})
vim.keymap.set("n", "<leader>tf", vimtreeapi.tree.focus, {silent = true})

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
vim.cmd.colorscheme "catppuccin-mocha" -- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha

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
vim.api.nvim_command("set clipboard=unnamedplus")
vim.api.nvim_command("set cursorline")
vim.api.nvim_command("set ttyfast")           
vim.api.nvim_command("set tags=tags")
vim.api.nvim_command("filetype plugin indent on")
vim.api.nvim_command("set hidden")
vim.api.nvim_command("set nobackup")
vim.api.nvim_command("set nowritebackup")
vim.api.nvim_command("set cmdheight=2")
vim.api.nvim_command("set tags=tags")

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
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
-- keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion
keyset("i", "<c-j>", "coc#refresh()", {silent = true, expr = true})

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})


-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})


-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})


-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})


-- Formatting selected code
keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})


-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})

-- Apply codeAction to the selected region
-- Example: `<leader>aap` for current paragraph
local opts = {silent = true, nowait = true}
keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

-- Remap keys for apply code actions at the cursor position.
keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
-- Remap keys for apply source code actions for current file.
keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
-- Apply the most preferred quickfix action on the current line.
keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

-- Remap keys for apply refactor code actions.
keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- Run the Code Lens actions on the current line
keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)


-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)


-- Remap <C-f> and <C-b> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true, expr = true}
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keyset("i", "<C-f>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-b>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)


-- Use CTRL-S for selections ranges
-- Requires 'textDocument/selectionRange' support of language server
keyset("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
keyset("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})


-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true}
-- Show all diagnostics
keyset("n", "<leader>di", ":<C-u>CocList diagnostics<cr>", opts)
-- Manage extensions
keyset("n", "<leader>ex", ":<C-u>CocList extensions<cr>", opts)
-- Show commands
keyset("n", "<leader>cm", ":<C-u>CocList commands<cr>", opts)
-- Find symbol of current document
keyset("n", "<leader>ol", ":<C-u>CocList outline<cr>", opts)
-- Search workspace symbols
keyset("n", "<leader>s", ":<C-u>CocList -I symbols<cr>", opts)
-- Do default action for next item
keyset("n", "<leader>j", ":<C-u>CocNext<cr>", opts)
-- Do default action for previous item
keyset("n", "<leader>k", ":<C-u>CocPrev<cr>", opts)
-- Resume latest coc list
keyset("n", "<leader>p", ":<C-u>CocListResume<cr>", opts)
-- coc.vim config end

-- vim-startify no chagne directory
vim.g.startify_change_to_dir = 0


-- vim.api.nvim_create_autocmd({"BufEnter", "BufRead"}, {
--     pattern = { "*.ts", "*.js", "*.tsx", "*.jsx", "*.html", "*.mjs", "*.css" },
--     callback = function(ev) 
--         vim.api.nvim_command("setlocal ts=2 sw=2")
--     end
-- })

local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)
