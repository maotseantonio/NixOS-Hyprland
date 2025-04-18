local term = require("wezterm")
local act = term.action
local gui = term.gui

local workspace_switcher = term.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
local resurrect = term.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

local M = {}

function M.options(config)
	config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }

	--=========================================
	-- Custom Launcher Functions
	--=========================================
	local fuzzy_commands =
		act.ShowLauncherArgs({ title = "  Fuzzy Commands", flags = "FUZZY|KEY_ASSIGNMENTS|COMMANDS" })
	local fuzzy_domains =
		act.ShowLauncherArgs({ title = "  Find Domains", flags = "FUZZY|LAUNCH_MENU_ITEMS|DOMAINS" })
	local fuzzy_tabs = act.ShowLauncherArgs({ title = " Tabs", flags = "FUZZY|WORKSPACES|TABS|DOMAINS" })
	local fuzzy_workspaces = act.ShowLauncherArgs({ title = " Workspaces", flags = "FUZZY|WORKSPACES" })
	local workspace_new = act.PromptInputLine({
		description = term.format({
			{ Attribute = { Intensity = "Bold" } },
			{ Foreground = { AnsiColor = "Fuchsia" } },
			{ Text = "Enter name for new workspace" },
		}),
		action = term.action_callback(function(window, pane, line)
			-- line will be `nil` if they hit escape without entering anything
			-- An empty string if they just hit enter
			-- Or the actual line of text they wrote
			if line then
				window:perform_action(
					act.SwitchToWorkspace({
						name = line,
					}),
					pane
				)
			end
		end),
	})
	local monitor = act.SwitchToWorkspace({
		name = "monitor",
		spwn = {
			args = { "btop" },
		},
	})
	--=========================================

	--=========================================
	-- General Keybindings
	--=========================================
	config.keys = {
		{ key = "c", mods = "CTRL|SHIFT", action = act({ CopyTo = "ClipboardAndPrimarySelection" }) },
		{ key = "v", mods = "CTRL|SHIFT", action = act({ PasteFrom = "Clipboard" }) },
		{ key = "r", mods = "LEADER", action = act.ReloadConfiguration },

		--=========================================
		-- Launcher Keybindings
		--=========================================
		{ key = "F10", action = fuzzy_domains },
		{ key = "F12", action = fuzzy_commands },
		{ key = "F9", action = fuzzy_tabs },
		{ key = "Tab", mods = "LEADER", action = fuzzy_tabs },
		{ key = "N", mods = "LEADER|SHIFT", action = workspace_new },
		{ key = "o", mods = "LEADER", action = fuzzy_domains },
		{ key = "p", mods = "LEADER", action = fuzzy_commands },
		{ key = "w", mods = "LEADER", action = fuzzy_workspaces },
		{ key = "t", mods = "LEADER", action = workspace_switcher.switch_workspace() },
		{ key = "t", mods = "CTRL|SHIFT", action = workspace_switcher.switch_workspace() },

		{ key = "S", mods = "LEADER|SHIFT", action = act({ EmitEvent = "save_session" }) },
		{ key = "L", mods = "LEADER|SHIFT", action = act({ EmitEvent = "load_session" }) },
		{ key = "R", mods = "LEADER|SHIFT", action = act({ EmitEvent = "restore_session" }) },
		{
			key = "s",
			mods = "ALT",
			action = term.action_callback(function(win, pane)
				resurrect.save_state(resurrect.workspace_state.get_workspace_state())
				resurrect.window_state.save_window_action()
			end),
		},
		{
			key = "r",
			mods = "ALT",
			action = term.action_callback(function(win, pane)
				resurrect.fuzzy_load(win, pane, function(id, label)
					local type = string.match(id, "^([^/]+)") -- match before '/'
					id = string.match(id, "([^/]+)$") -- match after '/'
					id = string.match(id, "(.+)%..+$") -- remove file extention
					local opts = {
						relative = true,
						restore_text = true,
						on_pane_restore = resurrect.tab_state.default_on_pane_restore,
					}
					if type == "workspace" then
						local state = resurrect.load_state(id, "workspace")
						resurrect.workspace_state.restore_workspace(state, opts)
					elseif type == "window" then
						local state = resurrect.load_state(id, "window")
						resurrect.window_state.restore_window(pane:window(), state, opts)
					elseif type == "tab" then
						local state = resurrect.load_state(id, "tab")
						resurrect.tab_state.restore_tab(pane:tab(), state, opts)
					end
				end)
			end),
		},

		-- { key = "s", mods = "CTRL|SHIFT", action = workspace_switcher.switch_workspace() }) }
		-- table.insert(keys, { key = "t", mods = "CTRL|SHIFT", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) })
		-- table.insert(keys, { key = "[", mods = "CTRL|SHIFT", action = act.SwitchWorkspaceRelative(1) })
		-- table.insert(keys, { key = "]", mods = "CTRL|SHIFT", action = act.SwitchWorkspaceRelative(-1) })

		--=========================================

		--=========================================
		-- Modes -  Select, Copy, Keybindings
		--=========================================
		{ key = "s", mods = "LEADER", action = act({ Search = { CaseInSensitiveString = "" } }) },
		{ key = "f", mods = "LEADER", action = "QuickSelect" },
		{ key = "y", mods = "LEADER", action = "ActivateCopyMode" },
		{ key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
		--=========================================

		--=========================================
		-- Panes, Windows Keybindings
		--=========================================
		{ key = "H", mods = "LEADER|SHIFT", action = act({ AdjustPaneSize = { "Left", 5 } }) },
		{ key = "J", mods = "LEADER|SHIFT", action = act({ AdjustPaneSize = { "Down", 5 } }) },
		{ key = "K", mods = "LEADER|SHIFT", action = act({ AdjustPaneSize = { "Up", 5 } }) },
		{ key = "L", mods = "LEADER|SHIFT", action = act({ AdjustPaneSize = { "Right", 5 } }) },
		{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
		{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
		{ key = "0", mods = "CTRL", action = act.ResetFontSize },
		-- { key = "w", mods = "LEADER", action = act.CloseCurrentTab({ confirm = true }) },
		{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = false }) },
		{ key = "-", mods = "LEADER", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
		{ key = "=", mods = "LEADER", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
		{ key = "c", mods = "LEADER", action = act({ SpawnTab = "CurrentPaneDomain" }) },
		{ key = "q", mods = "LEADER", action = act.PaneSelect },
		{ key = "n", mods = "LEADER", action = act.SpawnWindow },
		{
			key = "F8",
			action = term.action_callback(function(window)
				window:maximize()
			end),
		},
		{ key = "F7", action = act.Hide },
		{ key = "F11", action = act.ToggleFullScreen },
		--=========================================

		--=========================================
		-- Navigation  Keybindings
		--=========================================
		{ key = "Tab", mods = "CTRL", action = act({ ActivateTabRelative = 1 }) },
		{ key = "1", mods = "LEADER", action = act({ ActivateTab = 0 }) },
		{ key = "2", mods = "LEADER", action = act({ ActivateTab = 1 }) },
		{ key = "3", mods = "LEADER", action = act({ ActivateTab = 2 }) },
		{ key = "4", mods = "LEADER", action = act({ ActivateTab = 3 }) },
		{ key = "5", mods = "LEADER", action = act({ ActivateTab = 4 }) },
		{ key = "6", mods = "LEADER", action = act({ ActivateTab = 5 }) },
		{ key = "7", mods = "LEADER", action = act({ ActivateTab = 6 }) },
		{ key = "8", mods = "LEADER", action = act({ ActivateTab = 7 }) },
		{ key = "9", mods = "LEADER", action = act({ ActivateTab = 8 }) },
		{ key = "1", mods = "CTRL", action = act({ ActivateTab = 0 }) },
		{ key = "2", mods = "CTRL", action = act({ ActivateTab = 1 }) },
		{ key = "3", mods = "CTRL", action = act({ ActivateTab = 2 }) },
		{ key = "4", mods = "CTRL", action = act({ ActivateTab = 3 }) },
		{ key = "5", mods = "CTRL", action = act({ ActivateTab = 4 }) },
		{ key = "6", mods = "CTRL", action = act({ ActivateTab = 5 }) },
		{ key = "7", mods = "CTRL", action = act({ ActivateTab = 6 }) },
		{ key = "8", mods = "CTRL", action = act({ ActivateTab = 7 }) },
		{ key = "9", mods = "CTRL", action = act({ ActivateTab = 8 }) },
		{ key = "h", mods = "CTRL", action = act({ ActivateTabRelative = -1 }) },
		{ key = "l", mods = "CTRL", action = act({ ActivateTabRelative = 1 }) },
		{ key = ">", mods = "LEADER|SHIFT", action = act.SwitchWorkspaceRelative(1) },
		{ key = "<", mods = "LEADER|SHIFT", action = act.SwitchWorkspaceRelative(-1) },
		{ key = "h", mods = "LEADER", action = act({ ActivatePaneDirection = "Left" }) },
		{ key = "j", mods = "LEADER", action = act({ ActivatePaneDirection = "Down" }) },
		{ key = "k", mods = "LEADER", action = act({ ActivatePaneDirection = "Up" }) },
		{ key = "l", mods = "LEADER", action = act({ ActivatePaneDirection = "Right" }) },
		--=========================================
	}
	--=========================================

	--=========================================
	-- Copy Mode
	--=========================================
	local copy_mode = gui.default_key_tables().copy_mode
	table.insert(copy_mode, { key = "h", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") })
	table.insert(copy_mode, { key = "l", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") })
	table.insert(copy_mode, {
		key = "y",
		mods = "NONE",
		action = act.Multiple({
			act.CopyTo("PrimarySelection"),
			act.ClearSelection,
			act.CopyMode("ClearSelectionMode"),
		}),
	})
	--=========================================

	--=========================================
	-- Search Mode
	--=========================================
	local search_mode = gui.default_key_tables().search_mode
	table.insert(search_mode, { key = "c", mods = "CTRL", action = act.CopyMode("Close") })
	--=========================================

	--=========================================
	-- Switch Copy <=> Search Mode
	--=========================================
	table.insert(copy_mode, { key = "/", mods = "NONE", action = act.Search({ CaseInSensitiveString = "" }) })
	table.insert(search_mode, { key = "Enter", mods = "SHIFT", action = act.ActivateCopyMode })

	--=========================================
	-- Super Mode, Key_Tables
	--=========================================
	config.key_tables = {
		copy_mode = copy_mode,
		search_mode = search_mode,
		super = {
			{ key = "`", mods = "CTRL", action = "PopKeyTable" },
			{ key = "Space", mods = "NONE", action = act.Search({ CaseInSensitiveString = "" }) },
			{ key = "n", mods = "CTRL", action = act.CopyMode("NextMatch") },
			{ key = "p", mods = "CTRL", action = act.CopyMode("PriorMatch") },
			{ key = "r", mods = "CTRL", action = act.CopyMode("CycleMatchType") },
			{ key = "PageUp", mods = "NONE", action = act.CopyMode("PriorMatchPage") },
			{ key = "PageDown", mods = "NONE", action = act.CopyMode("NextMatchPage") },
			{ key = "s", mods = "CTRL", action = act.CopyMode("ClearPattern") },
			{
				key = "Escape",
				mods = "NONE",
				action = act.Multiple({ act.CopyMode("Close"), "PopKeyTable" }),
			},
			{ key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },
			{ key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{ key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
			{ key = "K", mods = "CTRL", action = act.ScrollByPage(-0.5) },
			{ key = "J", mods = "CTRL", action = act.ScrollByPage(1) },
			{ key = "k", mods = "CTRL", action = act.ScrollByLine(-1) },
			{ key = "j", mods = "CTRL", action = act.ScrollByLine(1) },
			{ key = "c", mods = "CTRL|SHIFT", action = act({ CopyTo = "ClipboardAndPrimarySelection" }) },
		},
	}

	--=========================================
	-- Mouse Bindings
	--=========================================
	config.mouse_bindings = {
		-- Scrolling up while holding CTRL increases the font size
		{
			event = { Down = { streak = 1, button = { WheelUp = 1 } } },
			mods = "CTRL",
			action = act.IncreaseFontSize,
		},

		-- Scrolling down while holding CTRL decreases the font size
		{
			event = { Down = { streak = 1, button = { WheelDown = 1 } } },
			mods = "CTRL",
			action = act.DecreaseFontSize,
		},
		{
			event = { Down = { streak = 1, button = "Right" } },
			mods = "NONE",
			action = term.action_callback(function(window, pane)
				local has_selection = window:get_selection_text_for_pane(pane) ~= ""
				if has_selection then
					window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
					window:perform_action(act.ClearSelection, pane)
				else
					window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
				end
			end),
		},
	}
end

return M
