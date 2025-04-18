local term = require("wezterm")

local M = {}

local ansi_tn = { "#1d202f", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#a9b1d6" }

local brights_tn = { "#414868", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#c0caf5" }

local ansi = {
	"#45475a",
	"#f38ba8",
	"#a6e3a1",
	"#f9e2af",
	"#89b4fa",
	"#f5c2e7",
	"#94e2d5",
	"#bac2de",
}
local background = "#1e1e2e"
local brights = {
	"#585b70",
	"#f38ba8",
	"#a6e3a1",
	"#f9e2af",
	"#89b4fa",
	"#f5c2e7",
	"#94e2d5",
	"#a6adc8",
}

---- Appearance
-- config.front_end = "OpenGL"
-- Color pallete
M.colors_old = {
	rosewater = "#f5e0dc",
	flamingo = "#f2cdcd",
	pink = "#f5c2e7",
	mauve = "#cba6f7",
	red = "#f38ba8",
	maroon = "#eba0ac",
	peach = "#fab387",
	yellow = "#f9e2af",
	green = "#a6e3a1",
	teal = "#94e2d5",
	sky = "#89dceb",
	sapphire = "#74c7ec",
	blue = "#89b4fa",
	lavender = "#b4befe",
	text = "#cdd6f4",
	subtext1 = "#bac2de",
	subtext0 = "#a6adc8",
	overlay2 = "#9399b2",
	overlay1 = "#7f849c",
	overlay0 = "#6c7086",
	surface2 = "#585b70",
	surface1 = "#45475a",
	surface0 = "#313244",
	base = "#1e1e2e",
	mantle = "#181825",
	-- crust = "rgba(17,17,27,0.618)",
	crust = "rgba(36,40,59,0.618)",
	-- crust = "rgba(36,40,59,1)",
	transparent = "rgba(0,0,0,0)",
	tab_active = "#7aa2f7",
	tab_inactive = "#1f2335",
	tab_fg = "#a9b1d6",
}

M.colors = {
	rosewater = "#f5e0dc",
	flamingo = "#f2cdcd",
	pink = "#f5c2e7",
	mauve = "#cba6f7",
	red = "#f38ba8",
	maroon = "#eba0ac",
	peach = "#fab387",
	yellow = "#f9e2af",
	green = "#a6e3a1",
	teal = "#94e2d5",
	sky = "#89dceb",
	sapphire = "#74c7ec",
	blue = "#89b4fa",
	lavender = "#b4befe",
	text = "#cdd6f4",
	subtext1 = "#bac2de",
	subtext0 = "#a6adc8",
	overlay2 = "#9399b2",
	overlay1 = "#7f849c",
	overlay0 = "#6c7086",
	surface2 = "#585b70",
	surface1 = "#45475a",
	surface0 = "#313244",
	base = "#1e1e2e",
	mantle = "#181825",
	-- crust = "#11111b",
	crust = "rgba(17,17,27,0.618)",
	transparent = "rgba(0,0,0,0)",
	tab_active = "#89b4fa",
	tab_inactive = "#1f2335",
	tab_fg = "#a9b1d6",
}

function M.options(config)
	config.status_update_interval = 1000
	-- config.color_scheme = "tokyonight_storm"
	config.color_scheme = "Catppuccin Mocha"

	config.animation_fps = 240
	config.max_fps = 240

	config.initial_cols = 117
	config.initial_rows = 32
	config.font = term.font({
		family = "JetBrainsMono Nerd Font",
		weight = "Regular",
		stretch = "Normal",
		style = "Normal",
		-- harfbuzz_features = { "calt=1", "clig=1", "liga=1" },
		scale = 1.0,
	})
	config.font_size = 13
	config.window_decorations = "RESIZE"
	config.text_background_opacity = 1.0
	config.window_background_opacity = 0.85
	config.window_frame = {
		border_left_width = "1px",
		border_right_width = "1px",
		border_bottom_height = "0px",
		border_top_height = "0px",
		border_left_color = M.colors.crust,
		border_right_color = M.colors.crust,
		border_bottom_color = M.colors.crust,
		border_top_color = M.colors.crust,
		font_size = 13,
	}
	config.enable_scroll_bar = false
	config.default_cursor_style = "SteadyBar"
	config.cursor_blink_rate = 333
	config.inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 }
	config.window_padding = { left = "0px", right = "0px", top = "0px", bottom = "0px" }
	config.colors = {
		background = M.colors.crust,
		-- background = M.colors.transparent,
		tab_bar = {
			background = M.colors.transparent,
			active_tab = {
				bg_color = M.colors.tab_active,
				fg_color = M.colors.transparent,
			},
			inactive_tab = {
				fg_color = M.colors.tab_fg,
				bg_color = M.colors.transparent,
			},
		},
	}

	----- Misc
	-- config.adjust_window_size_when_changing_font_size = true
	config.audible_bell = "Disabled"
	config.exit_behavior = "Close"
	config.window_close_confirmation = "NeverPrompt"
	config.scrollback_lines = 50000
	config.tab_max_width = 9999
	config.hide_tab_bar_if_only_one_tab = true
	config.tab_bar_at_bottom = true
	config.use_fancy_tab_bar = false
	config.show_new_tab_button_in_tab_bar = false
	config.allow_win32_input_mode = true
	config.disable_default_key_bindings = true
end

return M
