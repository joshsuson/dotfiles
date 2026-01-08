-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
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

-- Love2D commands
vim.keymap.set("n", "<leader>ls", ":LoveStart<CR>", { silent = true, desc = "Start Love2D" })
vim.keymap.set("n", "<leader>lx", ":LoveStop<CR>", { silent = true, desc = "Stop Love2D" })
