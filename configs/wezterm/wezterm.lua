
-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

--local act = wezterm.action
local gpus = wezterm.gui.enumerate_gpus()
-- This table will hold the ration.
local config = {}

function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha"
	else
		return "Catppuccin Latte"
	end
end

if wezterm.builder then
	config = wezterm.builder()
end

-- This is where you actually apply your choices
config = {
	-- For example, changing the color scheme:
	color_scheme = scheme_for_appearance(get_appearance()),
	-- color_scheme = "Catppuccin Macchiato",
	font = wezterm.font_with_fallback({
		{
			family = "JetBrainsMono Nerd Font",
			weight = "Regular",
		},
		{
			family = "JetBrainsMono Nerd Font",
			weight = "Regular",
			scale = 0.9,
		},
		{ family = "JetBrainsMono Nerd Font", weight = "Medium" },
		-- { family = "HarmonyOS Sans SC", scale = 0.9 },
		"monospace",
	}),
	font_size = 15.0,
	line_height = 1.0,
	use_cap_height_to_scale_fallback_fonts = true,
	window_background_opacity = 0.75,
	text_background_opacity = 1.0,
	bold_brightens_ansi_colors = false,
  front_end = "WebGpu",
  webgpu_preferred_adapter = gpus[0],
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

 background = {
    {
      source = {
        Color="#181825"
      },
      height = "100%",
      width = "100%",
    },
    {
      source = {
        File = '/home/antonio/.config/hypr/wallpaper_effects/.wallpaper_current',
        --File = '/home/antonio/.config/wezterm/nixos.png',
      },
      opacity = 0.05,
      vertical_align = "Middle",
      horizontal_align = "Center",
      height = "1824",
      width = "2724",
      repeat_y = "NoRepeat",
      repeat_x = "NoRepeat",
    },
  },

	-- Tab bar
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	show_tab_index_in_tab_bar = true,
	show_new_tab_button_in_tab_bar = false,
	tab_bar_at_bottom = true,
	window_frame = {
		font = wezterm.font({
			family = "RobotoMono Nerd Font",
			weight = "Bold",
		}),
		font_size = 10.0,
		active_titlebar_bg = "#24273a",
		inactive_titlebar_bg = "#24273a",
	},
	colors = {
		tab_bar = {
			inactive_tab_edge = "#1e1e2e",
			background = "transparent",
			-- The active tab is the one that has focus in the window
			active_tab = {
				-- The color of the background area for the tab
				bg_color = "#c6a0f6",
				-- The color of the text for the tab
				fg_color = "#1e2030",

				-- Specify whether you want "Half", "Normal" or "Bold" intensity for the
				-- label shown for this tab.
				-- The default is "Normal"
				intensity = "Normal",

				-- Specify whether you want "None", "Single" or "Double" underline for
				-- label shown for this tab.
				-- The default is "None"
				underline = "None",

				-- Specify whether you want the text to be italic (true) or not (false)
				-- for this tab.  The default is false.
				italic = false,

				-- Specify whether you want the text to be rendered with strikethrough (true)
				-- or not for this tab.  The default is false.
				strikethrough = false,
			},

			-- Inactive tabs are the tabs that do not have focus
			inactive_tab = {
				bg_color = "transparent", -- "#363a4f",
				fg_color = "#a5adcb",
			},

			-- You can configure some alternate styling when the mouse pointer
			-- moves over inactive tabs
			inactive_tab_hover = {
				bg_color = "#b7bdf8",
				fg_color = "#1e2030",
				italic = true,
			},

			-- The new tab button that let you create new tabs
			new_tab = {
				bg_color = "#8aadf4",
				fg_color = "#808080",
			},

			-- You can configure some alternate styling when the mouse pointer
			-- moves over the new tab button
			new_tab_hover = {
				bg_color = "#f0c6c6",
				fg_color = "#363a4f",
				italic = true,
			},
		},
		compose_cursor = "#ee99a0",
	},

	scrollback_lines = 5000,

	-- curse
	cursor_blink_ease_in = "Linear",
	cursor_blink_ease_out = "Linear",
	cursor_blink_rate = 1000,
	default_cursor_style = "BlinkingBar",

	enable_wayland = true,
	check_for_updates = false,
	default_prog = { "fish" },
	automatically_reload_config = true,
	window_close_confirmation = "NeverPrompt",

	-- The Launcher Menu
	launch_menu = {
		{
			label = "Btotom",
			args = { "btm" },
		},
		{
			label = "Files",
			args = { "yazi" },
		},
		{
			label = "Lazygit",
			args = { "lazygit" },
		},
		{
			label = "Lazysql",
			args = { "lazysql" },
		},
		{
			label = "Music",
			args = { "ncmpcpp" },
		},
	},

	-- Command palette
	-- Ctrl + Shift + p
	command_palette_rows = 16,
	command_palette_font_size = 16.0,
	command_palette_bg_color = "#363a4f",
	command_palette_fg_color = "rgba(202, 211, 245, 0.8)",

	-- Keybinds
	disable_default_key_bindings = false,
	disable_default_mouse_bindings = false,
	mouse_bindings = {
		-- Bind 'Up' event of CTRL-Click to open hyperlinks
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = act.OpenLinkAtMouseCursor,
		},
		-- Disable the 'Down' event of CTRL-Click to avoid weird program behaviors
		{
			event = { Down = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = act.Nop,
		},
	},

	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },

	keys = {
		{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
		{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
		{ key = "l", mods = "ALT", action = act.ShowLauncher },
		{
			key = [[\]],
			mods = "CTRL|ALT",
			action = act({
				SplitHorizontal = { domain = "CurrentPaneDomain" },
			}),
		},
		{
			key = [[\]],
			mods = "CTRL",
			action = act({
				SplitVertical = { domain = "CurrentPaneDomain" },
			}),
		},
		{
			key = "z",
			mods = "ALT",
			action = act.TogglePaneZoomState,
		},
		{
			key = "q",
			mods = "ALT",
			action = act({ CloseCurrentPane = { confirm = false } }),
		},
		{
			key = "h",
			mods = "CTRL",
			action = act({ ActivatePaneDirection = "Left" }),
		},
		{
			key = "l",
			mods = "CTRL",
			action = act({ ActivatePaneDirection = "Right" }),
		},
		{
			key = "k",
			mods = "CTRL",
			action = act({ ActivatePaneDirection = "Up" }),
		},
		{
			key = "j",
			mods = "CTRL",
			action = act({ ActivatePaneDirection = "Down" }),
		},
		{
			key = "h",
			mods = "CTRL|ALT",
			action = act({ AdjustPaneSize = { "Left", 1 } }),
		},
		{
			key = "l",
			mods = "CTRL|ALT",
			action = act({ AdjustPaneSize = { "Right", 1 } }),
		},
		{
			key = "k",
			mods = "CTRL|ALT",
			action = act({ AdjustPaneSize = { "Up", 1 } }),
		},
		{
			key = "j",
			mods = "CTRL|ALT",
			action = act({ AdjustPaneSize = { "Down", 1 } }),
		},
		{
			-- browser-like bindings for tabbing
			key = "t",
			mods = "CTRL|SHIFT",
			action = act({ SpawnTab = "DefaultDomain" }),
		},
		{
			key = "w",
			mods = "ALT",
			action = act.CloseCurrentTab({ confirm = false }),
		},
		{ key = "LeftArrow", mods = "ALT", action = act.ActivateTabRelative(-1) },
		{ key = "RightArrow", mods = "ALT", action = act.ActivateTabRelative(1) },
		{
			key = ",",
			mods = "CTRL",
			action = act.SpawnCommandInNewTab({
				cwd = wezterm.home_dir,
				args = { "nvim", wezterm.config_file },
			}),
		},

		-- standard copy/paste bindings
		{
			key = "v",
			mods = "CTRL|SHIFT",
			action = act({ PasteFrom = "Clipboard" }),
		},
		{
			key = "c",
			mods = "CTRL|SHIFT",
			action = act({ CopyTo = "ClipboardAndPrimarySelection" }),
		},
	},
}
for i = 1, 8 do
	-- ALT + number to move to that position
	table.insert(config.keys, {
		key = tostring(i),
		mods = "ALT",
		action = act.ActivateTab(i - 1),
	})
end

-- Plugin
local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config, {
	modules = {
		spotify = {
			enabled = false,
		},
		clock = {
			enabled = false,
		},
	},
})

-- and finally, return the ration to wezterm
return config
