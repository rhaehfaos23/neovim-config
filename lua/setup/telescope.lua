-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require("telescope").setup({
	defaults = {},
	pickers = {
		find_files = {
			theme = "dropdown",
		},
		live_grep = {
			theme = "dropdown",
		},
		buffers = {
			theme = "dropdown",
		},
		help_tags = {
			theme = "dropdown",
		},
		tags = {
			theme = "dropdown",
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
		aerial = {
			-- Set the width of the first two columns (the second
			-- is relevant only when show_columns is set to 'both')
			col1_width = 4,
			col2_width = 30,
			-- How to format the symbols
			format_symbol = function(symbol_path, filetype)
				if filetype == "json" or filetype == "yaml" then
					return table.concat(symbol_path, ".")
				else
					return symbol_path[#symbol_path]
				end
			end,
			-- Available modes: symbols, lines, both
			show_columns = "both",
		},
	},
})

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("fzf")
require("telescope").load_extension("yank_history")
require("telescope").load_extension("aerial")
