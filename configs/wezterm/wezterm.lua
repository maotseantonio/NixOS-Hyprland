local wezterm = require 'wezterm'
local act = wezterm.action
local gpus = wezterm.gui.enumerate_gpus()
local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
--local font_family = 'CaskaydiaCove Nerd Font'
local font_family = 'IosevkaTermSlab Nerd Font'
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
--local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")

return {
 -- example enable spotify module
  enable_wayland = true,
  prefer_egl = true,
  font_size = 14,
  --font_stretch = "Oblique",
  --font = wezterm.font({family = font_family,}),
   font = wezterm.font(
    'JetBrainsMono Nerd Font',
    { stretch = 'Expanded', weight = 'Regular' }
  ),
  front_end = "WebGpu",
  webgpu_preferred_adapter = gpus[0],
  color_scheme = 'Catppuccin Mocha',
  default_cursor_style = "BlinkingBar",
  cursor_blink_rate = 600,
  cursor_thickness = '1.2pt',
  enable_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  --tab_bar_color = "#1e1e2e",

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
      opacity = 0.03,
      vertical_align = "Middle",
      horizontal_align = "Center",
      height = "1824",
      width = "2724",
      repeat_y = "NoRepeat",
      repeat_x = "NoRepeat",
    },
  },
  launch_menu = {
    {
      args = { 'btop' },
    },
    {
      args = { 'cmatrix' },
    },
    {
      args = { 'pipes-rs' },
    },
  },
  keys = {
    {
      key = 'j',
      mods = 'CTRL|SHIFT',
      action = act.ScrollByPage(1)
    },
    {
      key = 'k',
      mods = 'CTRL|SHIFT',
      action = act.ScrollByPage(-1)
    },
    {
      key = 'g',
      mods = 'CTRL|SHIFT',
      action = act.ScrollToTop
    },
    {
      key = 'e',
      mods = 'CTRL|SHIFT',
      action = act.ScrollToBottom
    },
    {
      key = 'p',
      mods = 'CTRL|SHIFT|SUPER',
      action = act.PaneSelect
    },
    {
      key = 'o',
      mods = 'CTRL|SHIFT|SUPER',
      action = act.PaneSelect { mode = "SwapWithActive" }
    },
    {
      key = '%',
      mods = 'CTRL|SHIFT|SUPER',
      action = act.SplitVertical { domain = 'CurrentPaneDomain' }
    },
    {
      key = '"',
      mods = 'CTRL|SHIFT|SUPER',
      action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }
    },
    {
      key = 'LeftArrow',
      mods = 'CTRL|SHIFT|SUPER',
      action = act.AdjustPaneSize { 'Left', 1 }
    },
    {
      key = 'RightArrow',
      mods = 'CTRL|SHIFT|SUPER',
      action = act.AdjustPaneSize { 'Right', 1 }
    },
    {
      key = 'UpArrow',
      mods = 'CTRL|SHIFT|SUPER',
      action = act.AdjustPaneSize { 'Up', 1 }
    },
    {
      key = 'DownArrow',
      mods = 'CTRL|SHIFT|SUPER',
      action = act.AdjustPaneSize { 'Down', 1 }
    },
    {
      key = 'h',
      mods = 'CTRL|SHIFT|SUPER',
      action = act.ActivatePaneDirection 'Left'
    },
    {
      key = 'l',
      mods = 'CTRL|SHIFT|SUPER',
      action = act.ActivatePaneDirection 'Right'
    },
    {
      key = 'k',
      mods = 'CTRL|SHIFT|SUPER',
      action = act.ActivatePaneDirection 'Up'
    },
    {
      key = 'j',
      mods = 'CTRL|SHIFT|SUPER',
      action = act.ActivatePaneDirection 'Down'
    },
    {
      key = 'z',
      mods = 'CTRL|SHIFT|SUPER',
      action = act.TogglePaneZoomState
    },
    {
      key = 'q',
      mods = 'CTRL|SHIFT|SUPER',
      action = act.CloseCurrentPane { confirm = true }
    },
    {
      key = 'b',
      mods = 'CTRL|SHIFT|SUPER',
      action = act.RotatePanes 'CounterClockwise'
    },
    {
      key = 'n',
      mods = 'CTRL|SHIFT|SUPER',
      action = act.RotatePanes 'Clockwise'
    },
    {
      key = 'd',
      mods = 'CTRL|SHIFT',
      action = act.ShowLauncher
    },
    { key = 't',
      mods = 'ALT',
      action = act.SpawnTab('DefaultDomain')
    },
    {
      key = ':',
      mods = 'CTRL|SHIFT',
      action = act.ClearSelection
    },
  },
}

