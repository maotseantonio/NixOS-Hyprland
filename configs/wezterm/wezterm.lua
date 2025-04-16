local wezterm = require 'wezterm';

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
local function basename(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local SOLID_LEFT_ARROW = utf8.char(0xe0ba)
local SOLID_LEFT_MOST = utf8.char(0x2588)
local SOLID_RIGHT_ARROW = utf8.char(0xe0bc)

local ADMIN_ICON = utf8.char(0xf49c)

local CMD_ICON = utf8.char(0xe62a)
local NU_ICON = utf8.char(0xe7a8)
local PS_ICON = utf8.char(0xe70f)
local ELV_ICON = utf8.char(0xfc6f)
local WSL_ICON = utf8.char(0xf83c)
local YORI_ICON = utf8.char(0xf1d4)
local NYA_ICON = utf8.char(0xf61a)

local VIM_ICON = utf8.char(0xe62b)
local PAGER_ICON = utf8.char(0xf718)
local FUZZY_ICON = utf8.char(0xf0b0)
local HOURGLASS_ICON = utf8.char(0xf252)
local SUNGLASS_ICON = utf8.char(0xf9df)

local PYTHON_ICON = utf8.char(0xf820)
local NODE_ICON = utf8.char(0xe74e)
local DENO_ICON = utf8.char(0xe628)
local LAMBDA_ICON = utf8.char(0xfb26)

local SUP_IDX = {"¹","²","³","⁴","⁵","⁶","⁷","⁸","⁹","¹⁰",
                 "¹¹","¹²","¹³","¹⁴","¹⁵","¹⁶","¹⁷","¹⁸","¹⁹","²⁰"}
local SUB_IDX = {"₁","₂","₃","₄","₅","₆","₇","₈","₉","₁₀",
                 "₁₁","₁₂","₁₃","₁₄","₁₅","₁₆","₁₇","₁₈","₁₉","₂₀"}

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local edge_background = "#161616"
  local background = "#4E4E4E"
  local foreground = "#1C1B19"
  local dim_foreground = "#3A3A3A"

  if tab.is_active then
    background = "#FBB829"
    foreground = "#1C1B19"
  elseif hover then
    background = "#FF8700"
    foreground = "#1C1B19"
  end

  local edge_foreground = background
  local process_name = tab.active_pane.foreground_process_name
  local pane_title = tab.active_pane.title
  local exec_name = basename(process_name):gsub("%.exe$", "")
  local title_with_icon

  if exec_name == "nu" then
    title_with_icon = NU_ICON .. " NuShell"
  elseif exec_name == "pwsh" then
    title_with_icon = PS_ICON .. " PS"
  elseif exec_name == "cmd" then
    title_with_icon = CMD_ICON .. " CMD"
  elseif exec_name == "elvish" then
    title_with_icon = ELV_ICON .. " Elvish"
  elseif exec_name == "wsl" or exec_name == "wslhost" then
    title_with_icon = WSL_ICON .. " WSL"
  elseif exec_name == "nyagos" then
    title_with_icon = NYA_ICON .. " " .. pane_title:gsub(".*: (.+) %- .+", "%1")
  elseif exec_name == "yori" then
    title_with_icon = YORI_ICON .. " " .. pane_title:gsub(" %- Yori", "")
  elseif exec_name == "nvim" then
    title_with_icon = VIM_ICON .. pane_title:gsub("^(%S+)%s+(%d+/%d+) %- nvim", " %2 %1")
  elseif exec_name == "bat" or exec_name == "less" or exec_name == "moar" then
    title_with_icon = PAGER_ICON .. " " .. exec_name:upper()
  elseif exec_name == "fzf" or exec_name == "hs" or exec_name == "peco" then
    title_with_icon = FUZZY_ICON .. " " .. exec_name:upper()
  elseif exec_name == "btm" or exec_name == "ntop" then
    title_with_icon = SUNGLASS_ICON .. " " .. exec_name:upper()
  elseif exec_name == "python" or exec_name == "hiss" then
    title_with_icon = PYTHON_ICON .. " " .. exec_name
  elseif exec_name == "node" then
    title_with_icon = NODE_ICON .. " " .. exec_name:upper()
  elseif exec_name == "deno" then
    title_with_icon = DENO_ICON .. " " .. exec_name:upper()
  elseif exec_name == "bb" or exec_name == "cmd-clj" or exec_name == "janet" or exec_name == "hy" then
    title_with_icon = LAMBDA_ICON .. " " .. exec_name:gsub("bb", "Babashka"):gsub("cmd%-clj", "Clojure")
  else
    title_with_icon = HOURGLASS_ICON .. " " .. exec_name
  end
  if pane_title:match("^Administrator: ") then
    title_with_icon = title_with_icon .. " " .. ADMIN_ICON
  end
  local left_arrow = SOLID_LEFT_ARROW
  if tab.tab_index == 0 then
    left_arrow = SOLID_LEFT_MOST
  end
  local id = SUB_IDX[tab.tab_index+1]
  local pid = SUP_IDX[tab.active_pane.pane_index+1]
  local title = " " .. wezterm.truncate_right(title_with_icon, max_width-6) .. " "

  return {
    {Attribute={Intensity="Bold"}},
    {Background={Color=edge_background}},
    {Foreground={Color=edge_foreground}},
    {Text=left_arrow},
    {Background={Color=background}},
    {Foreground={Color=foreground}},
    {Text=id},
    {Text=title},
    {Foreground={Color=dim_foreground}},
    {Text=pid},
    {Background={Color=edge_background}},
    {Foreground={Color=edge_foreground}},
    {Text=SOLID_RIGHT_ARROW},
    {Attribute={Intensity="Normal"}},
  }
end)


return {
  --color_scheme = "srcery",
  color_scheme = "Oxocarbon Dark",
  font_dirs = {"fonts"},
  font_size = 15.0,
  dpi = 96.0,
  freetype_load_target = "Normal",
  font = wezterm.font_with_fallback({
--    "JetBrainsMono Nerd Font",
    "CaskaydiaCove Nerd Font"
  }),
  tab_max_width = 60,
  enable_scroll_bar = true,
  use_fancy_tab_bar = false,
  window_background_opacity = 0.78,
  default_prog = {"fish"},
  set_environment_variables = {
    LANG = "en_US.UTF-8",
    PATH = wezterm.executable_dir .. ";" .. os.getenv("PATH"),
  },
  colors = {
    tab_bar = {
      background = "#121212",
      new_tab = {bg_color = "#121212", fg_color = "#FCE8C3", intensity = "Bold"},
      new_tab_hover = {bg_color = "#121212", fg_color = "#FBB829", intensity = "Bold"},
      active_tab = {bg_color = "#121212", fg_color = "#FCE8C3"},
    }
  },
  window_background_gradient = {
    orientation = "Vertical",
    interpolation = "Linear",
    blend = "Rgb",
    colors = {
      "#121212",
      "#202020"
    }
  },
  visual_bell = {
    fade_in_duration_ms = 75,
    fade_out_duration_ms = 75,
    target = "CursorColor",
  },
  launch_menu = {
	{
		label = "Bottom",
		args = {"btm.exe"},
	},
	{
		label = "ntop",
		args = {"ntop.exe"},
	},
	{
		label = "Cmder",
		args = {"cmd.exe", "/k", "D:/Scoop/apps/cmder/current/vendor/init.bat", "/f", "/nix_tools", "0"},
	},
	{
		label = "Pwsh",
		args = {"pwsh.exe", "-nol", "-noe"},
	},
	{
		label = "NyaGOS",
		args = {"nyagos.exe", "--glob"},
	},
	{
		label = "NuShell",
		args = {"nu.exe"},
	},
	{
		label = "Elvish",
		args = {"elvish.exe"},
	},
	{
		label = "Yori",
		args = {"yori.exe"},
	},
	{
		label = "VS",
		args = {"cmd.exe", "/k", "D:/Scoop/apps/cmder/current/vendor/init.bat", "/f", "/nix_tools", "0", "/VS"},
	},
	{
		label = "PSVS",
		args = {"pwsh.exe", "-noe", "-c", "&{Import-Module \"D:\\dev_env\\vs\\Common7\\Tools\\Microsoft.VisualStudio.DevShell.dll\"; Enter-VsDevShell 1c952f20}"},
	}
  },
  disable_default_key_bindings = true,
  leader = { key= "`"},
  --leader = { key= "CTRL|SPACE"},
  keys = {
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
}
