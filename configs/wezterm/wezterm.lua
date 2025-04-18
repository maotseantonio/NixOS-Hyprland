------------------------------------------------------
--               Wezterm configuration
------------------------------------------------------

local term = require("wezterm")
local act = term.action
local gui = term.gui
local mux = term.mux

local resurrect = term.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
local windows = require("windows") -- file located at ~/.config/wezterm/windows.lua
local linux = require("linux") -- file located at ~/.config/wezterm/linux.lua
local terminal = require("terminal")
local keymaps = require("keymaps")

local config = {}

-- For windows host custom configuration
if term.target_triple == "x86_64-pc-windows-msvc" then
	windows.options(config)
end

-- For linux host custom configuration
if term.target_triple == "x86_64-unknown-linux-gnu" then
	linux.options(config)
end

--Startup settings
--term.on("gui-startup", resurrect.resurrect_on_gui_startup)

terminal.options(config)
keymaps.options(config)

--------------------------------------
-- Local Functions
--------------------------------------
local function getDirectoryName(path)
	if not path then
		return "Unknown"
	end
	-- Remove any trailing slashes from the path
	path = path:gsub("/+$", "")
	-- Extract the last part of the path (the directory name)
	local directoryName = path:match("([^/]+)$")
	return directoryName or "Unknown"
end

local process_icons = { -- for get_process function
	["docker"] = term.nerdfonts.linux_docker,
	["docker-compose"] = term.nerdfonts.linux_docker,
	["psql"] = term.nerdfonts.dev_postgresql,
	["kuberlr"] = term.nerdfonts.linux_docker,
	["kubectl"] = term.nerdfonts.linux_docker,
	["stern"] = term.nerdfonts.linux_docker,
	["make"] = term.nerdfonts.seti_makefile,
	-- ["nvim"] = term.nerdfonts.custom_vim,
	-- ["vim"] = term.nerdfonts.dev_vim,
	["vim"] = "",
	["nvim"] = "",
	["go"] = term.nerdfonts.seti_go,
	["zsh"] = term.nerdfonts.dev_terminal,
	["bash"] = term.nerdfonts.cod_terminal_bash,
	["btm"] = term.nerdfonts.mdi_chart_donut_variant,
	["htop"] = term.nerdfonts.mdi_chart_donut_variant,
	["cargo"] = term.nerdfonts.dev_rust,
	["sudo"] = term.nerdfonts.fa_hashtag,
	["lazydocker"] = term.nerdfonts.linux_docker,
	["git"] = term.nerdfonts.dev_git,
	["lazygit"] = term.nerdfonts.dev_git,
	["lua"] = term.nerdfonts.seti_lua,
	["wget"] = term.nerdfonts.mdi_arrow_down_box,
	["curl"] = term.nerdfonts.mdi_flattr,
	["gh"] = term.nerdfonts.dev_github_badge,
	["ruby"] = term.nerdfonts.cod_ruby,
	["pwsh"] = term.nerdfonts.seti_powershell,
	["node"] = term.nerdfonts.dev_nodejs_small,
	["dotnet"] = term.nerdfonts.md_language_csharp,
}

local function get_process(process_name)
	-- local icon = process_icons[process_name] or string.format('[%s]', process_name)
	local icon = process_icons[process_name] or term.nerdfonts.seti_checkbox_unchecked

	return icon
end

term.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local pane = tab.active_pane
	local cwd_uri = pane.current_working_dir
	local directoryName = "Unknown"
	local process_name = tab.active_pane.foreground_process_name:match("([^/\\]+)%.exe$")
		or tab.active_pane.foreground_process_name:match("([^/\\]+)$")

	local process_icon = get_process(process_name) or tab.active_pane.foreground_process_name:match("([^/\\]+)$")

	local current_number = tab.tab_index + 1

	local numbers = {
		term.nerdfonts.md_numeric_1,
		term.nerdfonts.md_numeric_2,
		term.nerdfonts.md_numeric_3,
		term.nerdfonts.md_numeric_4,
		term.nerdfonts.md_numeric_5,
		term.nerdfonts.md_numeric_6,
		term.nerdfonts.md_numeric_7,
		term.nerdfonts.md_numeric_8,
		term.nerdfonts.md_numeric_9,
		term.nerdfonts.md_numeric_10,
	}

	if cwd_uri then
		-- Convert the URI to a string, remove the hostname, and decode %20s:
		local cwd_path = cwd_uri.file_path
		-- cwd_path = cwd_path:gsub("^file://[^/]+", "") -- not needed
		-- cwd_path = decodeURI(cwd_path) -- not needed

		-- Extract the directory name from the decoded path:
		directoryName = getDirectoryName(cwd_path)
	end

	-- local title = string.format(" %s %s %s ", (tab.tab_index + 1), process_icon, process_name)
	local title = string.format(" %s %s %s ", numbers[current_number], process_icon, process_name)

	return {
		{ Text = title },
	}
end)

local function recompute_padding(window)
	local window_dims = window:get_dimensions()
	local overrides = window:get_config_overrides() or {}

	if not window_dims.is_full_screen then
		if not overrides.window_padding then
			-- not changing anything
			return
		end
		overrides.window_padding = nil
	else
		-- Use only the middle 33%
		local third = math.floor(window_dims.pixel_width / 3)
		local new_padding = {
			left = 0,
			right = 0,
			top = 0,
			bottom = 0,
		}
		if overrides.window_padding and new_padding.left == overrides.window_padding.left then
			-- padding is same, avoid triggering further changes
			return
		end
		overrides.window_padding = new_padding
	end
	window:set_config_overrides(overrides)
end

term.on("window-resized", function(window, pane)
	recompute_padding(window)
end)
term.on("window-config-reloaded", function(window)
	recompute_padding(window)
end)

term.on("update-right-status", function(window, pane)
	local cells = {}
	local key_mode = window:active_key_table()

	-- Mode Section
	local mode = {
		["search_mode"] = "󰜏",
		["copy_mode"] = "",
	}
	if not key_mode then
		table.insert(cells, "")
	else
		table.insert(cells, mode[key_mode])
	end

	-- Workspace Section
	local workspace = window:active_workspace()

	if workspace == "default" then
		workspace = ""
	end

	table.insert(cells, workspace)

	-- Time Section
	local current_time = tonumber(term.strftime("%H"))
	-- stylua: ignore
	local time = {
		[00] = "",
		[01] = "",
		[02] = "",
		[03] = "",
		[04] = "",
		[05] = "",
		[06] = "",
		[07] = "",
		[08] = "",
		[09] = "",
		[10] = "󰗲",
		[11] = "",
		[12] = "",
		[13] = "",
		[14] = "",
		[15] = "",
		[16] = "",
		[17] = "",
		[18] = "",
		[19] = "󰗲",
		[20] = "",
		[21] = "",
		[22] = "",
		[23] = "",
	}
	local date = term.strftime("%H:%M:%S %a %b %d ")
	local date_time = time[current_time] .. " " .. date
	table.insert(cells, date_time)

	local text_fg = terminal.colors.transparent
	-- local SEPERATOR = " █"
	local SEPERATOR = "  "
	local pallete = {
		"#f7768e",
		"#9ece6a",
		"#7dcfff",
		"#bb9af7",
		"#e0af68",
		"#7aa2f7",
	}
	local cols = pane:get_dimensions().cols
	local padding = term.pad_right("", (cols / 2) - string.len(date_time) - 2)
	local elements = {}
	local num_cells = 0

	-- Translate into elements
	local function push(text, is_last)
		local cell_no = num_cells + 1
		if is_last then
			-- table.insert(elements, text_fg)
			table.insert(elements, { Text = padding })
		end
		table.insert(elements, { Foreground = { Color = pallete[cell_no] } })
		table.insert(elements, { Background = { Color = terminal.colors.transparent } })
		table.insert(elements, { Text = "" .. text .. "" })
		if not is_last then
			table.insert(elements, { Foreground = { Color = terminal.colors.transparent } })
			table.insert(elements, { Background = { Color = terminal.colors.transparent } })
			table.insert(elements, { Text = SEPERATOR })
		end
		num_cells = num_cells + 1
	end

	while #cells > 0 do
		local cell = table.remove(cells, 1)
		push(cell, #cells == 0)
	end

	window:set_right_status(term.format(elements))
end)

term.on("smart_workspace_switcher.workspace_switcher.created", function(window, path, label)
	local workspace_state = resurrect.workspace_state

	workspace_state.restore_workspace(resurrect.load_state(label, "workspace"), {
		window = window,
		relative = true,
		restore_text = true,
		on_pane_restore = resurrect.tab_state.default_on_pane_restore,
	})
end)

-- Saves the state whenever I select a workspace
term.on("smart_workspace_switcher.workspace_switcher.selected", function(window, path, label)
	local workspace_state = resurrect.workspace_state
	resurrect.save_state(workspace_state.get_workspace_state())
end)

return config
