local servers = {
  "html-ls",
  "ts-ls",
  "lua_ls",
  "intelephense",
  "tailwindcss",
}

local function get_capabilities()
  local caps = vim.lsp.protocol.make_client_capabilities()

  -- Prefer blink.cmp if present and returning a table
  local has_blink, blink = pcall(require, "blink.cmp")
  if has_blink and type(blink.get_lsp_capabilities) == "function" then
    local blink_caps = blink.get_lsp_capabilities()
    if type(blink_caps) == "table" then
      caps = vim.tbl_deep_extend("force", caps, blink_caps)
    end
  else
    -- Fallback to cmp_nvim_lsp if available
    local has_cmp, cmp = pcall(require, "cmp_nvim_lsp")
    if has_cmp and type(cmp.default_capabilities) == "function" then
      caps = cmp.default_capabilities(caps)
    end
  end

  -- Add any manual capabilities here
  caps.workspace = caps.workspace or {}
  caps.workspace.fileOperations = caps.workspace.fileOperations or {}
  caps.workspace.fileOperations.didRename = true
  caps.workspace.fileOperations.willRename = true

  return caps
end

local capabilities = get_capabilities()

for _, server_name in ipairs(servers) do
  -- Load server-specific config from lsp/<server-name>.lua
  local config_path = vim.fn.stdpath("config") .. "/lsp/" .. server_name .. ".lua"

  if vim.fn.filereadable(config_path) == 1 then
    -- Load the config file
    local ok, server_config = pcall(dofile, config_path)

    if ok and type(server_config) == "table" then
      -- Merge capabilities with server config
      server_config.capabilities = vim.tbl_deep_extend("force", capabilities, server_config.capabilities or {})

      -- Enable the LSP with the loaded config
      vim.lsp.enable(server_name, server_config)
    else
      -- If config load failed, enable with default config
      vim.notify(string.format("Failed to load config for %s, using defaults", server_name), vim.log.levels.WARN)
      vim.lsp.enable(server_name, { capabilities = capabilities })
    end
  else
    -- No config file, use default config
    vim.lsp.enable(server_name, { capabilities = capabilities })
  end
end
