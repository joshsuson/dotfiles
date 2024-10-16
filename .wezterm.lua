local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("Dank Mono")
config.font_size = 18
config.line_height = 1.5
config.cell_width = 1.1

config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 32,
	right = 32,
	top = 32,
	bottom = 32,
}
config.color_scheme = "Catppuccin Mocha"
-- config.colors = require("cyberdream")
return config
