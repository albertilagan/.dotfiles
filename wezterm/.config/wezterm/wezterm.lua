-- Pull in the wezterm API
local wezterm = require("wezterm")

local keys = require("keymaps")

local config = {
	-- general options
	font = wezterm.font("FiraCode Nerd Font Mono"),
	font_size = 16,
	color_scheme = "Catppuccin Mocha",
	enable_scroll_bar = false,
	tab_bar_at_bottom = true,
	adjust_window_size_when_changing_font_size = false,
	debug_key_events = false,
	enable_tab_bar = false,
	native_macos_fullscreen_mode = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	keys = keys,
	window_background_opacity = 0.8,
	macos_window_background_blur = 20,
	window_background_image = "/Users/albertilagan/.config/wezterm/blob_blue.gif",
	window_background_image_hsb = {
		brightness = 0.1,
		hue = 1,
		saturation = 1,
	},
	set_environment_variables = {
		TERM = "xterm-256color",
		LC_ALL = "en_US.UTF-8",
	},
	window_padding = {
		left = 30,
		right = 30,
		top = 30,
		bottom = 10,
	},
}

return config
