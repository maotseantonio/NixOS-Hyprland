local wezterm = require("wezterm")
local act = wezterm.action

local utils = require("utils")

local M = {}

local openUrl = act.QuickSelectArgs({
  label = "open url",
  patterns = { "https?://\\S+" },
  action = wezterm.action_callback(function(window, pane)
    local url = window:get_selection_text_for_pane(pane)
    wezterm.open_with(url)
  end),
})

local changeCtpFlavor = act.InputSelector({
  title = "Change Catppuccin flavor",
  choices = {
    { label = "Evergarden" },
    { label = "Espresso" },
    { label = "Mocha" },
    { label = "Macchiato" },
    { label = "Frappe" },
    { label = "Latte" },
  },
  action = wezterm.action_callback(function(window, _, _, label)
    if label then
      window:set_config_overrides({ color_scheme = "Catppuccin " .. label })
    end
  end),
})

local getNewName = act.PromptInputLine({
  description = "Enter new name for tab",
  action = wezterm.action_callback(function(window, pane, line)
    if line then
      window:active_tab():set_title(line)
    end
  end),
})

local keys = {
  
	{key="Tab", mods="CTRL", action=wezterm.action{ActivateTabRelative=1}},
	{key="Tab", mods="CTRL|SHIFT", action=wezterm.action{ActivateTabRelative=-1}},
	{key="Enter", mods="ALT", action="ToggleFullScreen"},
	
		{
			key = "n",
			mods = "LEADER",
			action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }),
		},
  {key="Insert", mods="SHIFT", action=wezterm.action{PasteFrom="PrimarySelection"}},
	{key="Insert", mods="CTRL", action=wezterm.action{CopyTo="PrimarySelection"}},
	{key="v", mods="LEADER", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
	{key="s", mods="LEADER", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
	{key="h", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Left"}},
	{key="l", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Right"}},
	{key="j", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Down"}},
	{key="k", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Up"}},
	{key="z", mods="LEADER", action="TogglePaneZoomState"},
	{key="/", mods="LEADER", action=wezterm.action{Search={CaseInSensitiveString=""}}},
	{key="q", mods="LEADER", action="QuickSelect"},
	{key="1", mods="LEADER", action=wezterm.action{ActivateTab=0}},
	{key="2", mods="LEADER", action=wezterm.action{ActivateTab=1}},
	{key="3", mods="LEADER", action=wezterm.action{ActivateTab=2}},
	{key="4", mods="LEADER", action=wezterm.action{ActivateTab=3}},
	{key="5", mods="LEADER", action=wezterm.action{ActivateTab=4}},
	{key="6", mods="LEADER", action=wezterm.action{ActivateTab=5}},
	{key="7", mods="LEADER", action=wezterm.action{ActivateTab=6}},
	{key="8", mods="LEADER", action=wezterm.action{ActivateTab=7}},
	{key="9", mods="LEADER", action=wezterm.action{ActivateTab=8}},
	{key="o", mods="LEADER", action="ActivateLastTab"},
	{key="g", mods="LEADER", action="ShowTabNavigator"},
	{key="c", mods="LEADER", action="ShowLauncher"},
	{key="r", mods="LEADER", action="ReloadConfiguration"},
	{key="x", mods="LEADER", action=wezterm.action{CloseCurrentPane={confirm=true}}},
	{key="x", mods="LEADER|SHIFT", action=wezterm.action{CloseCurrentTab={confirm=true}}},
	{key="`", mods="LEADER", action=wezterm.action{SendString="`"}},
}
local map = function(key, mods, action)
  if type(mods) == "string" then
    table.insert(keys, { key = key, mods = mods, action = action })
  elseif type(mods) == "table" then
    for _, mod in pairs(mods) do
      table.insert(keys, { key = key, mods = mod, action = action })
    end
  end
end

map("Enter", "ALT", act.ToggleFullScreen)

map("e", "CTRL|SHIFT", getNewName)
map("o", { "LEADER", "SUPER" }, openUrl)
map("t", "ALT", changeCtpFlavor)


local mods
if utils.is_windows() then
  mods = "ALT"
else
  mods = "CTRL"
end

M.apply = function(c)
  c.leader = {
    key = " ",
    mods = mods,
    timeout_milliseconds = math.maxinteger,
  }
  c.keys = keys
  -- c.disable_default_key_bindings = true
end
return M
