return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    vim.keymap.set("n", "<leader>ee", ":Neotree toggle filesystem reveal left<CR>", { desc = "Toggle file explorer" })
    vim.keymap.set("n", "<leader>eb", ":Neotree buffers reveal float<CR>", { desc = "Toggle buffer explorer" })
    vim.keymap.set('n', "<leader>ef", function()
        local reveal_file = vim.fn.expand('%:p')
        if (reveal_file == '') then
          reveal_file = vim.fn.getcwd()
        else
          local f = io.open(reveal_file, "r")
          if (f) then
            f.close(f)
          else
            reveal_file = vim.fn.getcwd()
          end
        end
        require('neo-tree.command').execute({
          action = "focus",      -- OPTIONAL, this is the default value
          source = "filesystem", -- OPTIONAL, this is the default value
          position = "left",     -- OPTIONAL, this is the default value
          reveal_file = reveal_file, -- path to file or folder to reveal
          reveal_force_cwd = true, -- change cwd without asking if needed
        })
      end,
      { desc = "Open neo-tree at current file or working directory" }
    );
  end
}
