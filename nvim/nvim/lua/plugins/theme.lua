return {
	-- {
	-- 	"catppuccin/nvim",
	-- 	lazy = false,
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("catppuccin").setup({
	-- 			flavour = "mocha",
	-- 		})
	--
	-- 		vim.cmd.colorscheme("catppuccin")
	-- 	end,
	--
	-- },
	-- {
	-- 	"Shatur/neovim-ayu",
	-- 	lazy = false,
	-- 	name = "ayu",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("ayu").setup({})
	--
	-- 		vim.cmd.colorscheme("ayu-dark")
	-- 	end,
	-- },
	{
		"olimorris/onedarkpro.nvim",
		lazy = false,
		name = "onedark",
		priority = 1000,
		config = function()
			require("onedarkpro").setup({
				theme = "onedark",
				styles = {
					comments = "italic",
					functions = "bold",
					keywords = "italic",
					strings = "italic",
					variables = "bold",
				},
			})

			vim.cmd.colorscheme("onedark_vivid")
		end,
	},
}
