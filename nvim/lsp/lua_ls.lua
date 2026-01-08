return {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim", "love" } },
      workspace = {
        -- Directory containing addons (LuaCATS Love2D lives here)
        userThirdParty = { os.getenv("HOME") .. "/.local/share/LuaAddons" },
        checkThirdParty = "Apply",
        -- Also include the Love2D stubs directly in the library for hover/completion
        library = {
          os.getenv("HOME") .. "/.local/share/LuaAddons/love2d/library",
        },
      },
    },
  },
}
