local M = {}

local state = {
  job_id = nil,
  cwd = nil,
}

local function is_running()
  if not state.job_id then
    return false
  end
  -- jobwait with timeout 0 returns -1 if still running
  local status = vim.fn.jobwait({ state.job_id }, 0)[1]
  return status == -1
end

local function notify(msg, level)
  vim.notify(msg, level or vim.log.levels.INFO, { title = "Love2D" })
end

function M.start(opts)
  if is_running() then
    notify("love is already running (stop first)", vim.log.levels.WARN)
    return
  end

  local dir = opts and opts.args ~= "" and opts.args or vim.fn.getcwd()
  state.cwd = dir

  local job_id = vim.fn.jobstart({ "love", dir }, {
    cwd = dir,
    pty = true,
    detach = false,
    on_exit = function(_, code)
      local message = string.format("love exited (code %d)", code or -1)
      state.job_id = nil
      state.cwd = nil
      vim.schedule(function()
        notify(message, code == 0 and vim.log.levels.INFO or vim.log.levels.WARN)
      end)
    end,
  })

  if job_id <= 0 then
    notify("failed to start love; is it installed and in PATH?", vim.log.levels.ERROR)
    return
  end

  state.job_id = job_id
  notify(string.format("love started in %s", dir))
end

function M.stop()
  if not is_running() then
    notify("love is not running", vim.log.levels.WARN)
    return
  end

  vim.fn.jobstop(state.job_id)
  notify("sent stop signal to love")
end

vim.api.nvim_create_user_command("LoveStart", function(opts)
  M.start(opts)
end, {
  nargs = "?",
  complete = "dir",
  desc = "Start Love2D in current (or provided) directory",
})

vim.api.nvim_create_user_command("LoveStop", function()
  M.stop()
end, {
  desc = "Stop Love2D process started from Neovim",
})

return M
