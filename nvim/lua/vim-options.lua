--Basic Settings
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set relativenumber")
vim.opt.number = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.signcolumn = "yes"

vim.opt.backspace = "indent,eol,start"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.g.mapleader = " "
vim.keymap.set("i", "jj", "<ESC>", { silent = true })
-- Allows you to move highlighted lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- Keeps cursor in the middle when half page jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- Allows search terms to stay in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- deletes current word into void buffer and pastes yanked word in it's place
vim.keymap.set("x", "<leader>p", [["_dP]])
-- allows leader "y" to yank to the * register
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- allows to delete to the void register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
-- Don't ever press Q according the primeagen
vim.keymap.set("n", "Q", "<nop>")
-- Replaces the word you are currently on in the whole file
vim.keymap.set("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- Removes highlights after searching
vim.keymap.set("n", "<leader>/", ":noh<cr>")
-- Toggles search highlights back on
vim.keymap.set("n", "<leader>h", ":set hls<cr>")
-- Window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Writing files
vim.keymap.set("n", "<leader>w", "<cmd>wa<CR>", { desc = "Write file" }) -- write file

vim.keymap.set("n", "<leader>be", function()
	require("telescope.builtin").buffers({
		sort_mru = true,
		initial_mode = "normal",
		layout_config = {
			preview_width = 0.45,
		},
	})
end, { desc = "Buffer Explorer" })
