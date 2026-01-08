return {
  {
    "adibhanna/laravel.nvim",
    ft = { "php", "blade" },
    dependencies = {
      "folke/snacks.nvim", -- Optional: for enhanced UI
    },
    config = function()
      local laravel = require("laravel")

      laravel.setup({
        notifications = false,
        debug = false,
        keymaps = true,
      })

      local function smart_laravel_goto(bufnr)
        pcall(vim.keymap.del, "n", "gd", { buffer = bufnr })

        vim.keymap.set("n", "gd", function()
          local is_laravel = _G.laravel_nvim and _G.laravel_nvim.is_laravel_project
          if is_laravel then
            local ok_cmd = pcall(vim.cmd, "LaravelGoto")
            if ok_cmd then
              return
            end
          end

          if vim.lsp.buf.definition then
            return vim.lsp.buf.definition()
          end

          vim.cmd.normal({ args = { "gd" }, bang = true })
        end, { buffer = bufnr, silent = true, noremap = true, desc = "Laravel goto definition (with LSP fallback)" })
      end

      local laravel_goto_group = vim.api.nvim_create_augroup("LaravelGotoOverride", { clear = true })

      local function maybe_map(event)
        local ft = vim.bo[event.buf].filetype
        if ft == "php" or ft == "blade" or ft == "blade.html" then
          vim.defer_fn(function()
            smart_laravel_goto(event.buf)
          end, 20)
        end
      end

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "FileType" }, {
        group = laravel_goto_group,
        callback = maybe_map,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = laravel_goto_group,
        callback = maybe_map,
      })
    end,
  },

  {
    "adibhanna/phprefactoring.nvim",
    enabled = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    ft = "php",
    config = function()
      require("phprefactoring").setup()
    end,
  },
}
