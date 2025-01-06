---@meta

--[[ 
@module 'wezterm-tabs'
@description A module for configuring and customizing Wezterm's tab bar appearance and behavior

This module provides functionality to:
- Configure tab bar position, visibility, and dimensions
- Customize tab appearance with icons and indicators
- Handle zoomed panes and multi-pane tabs
- Apply consistent styling across the tab bar

@example Basic usage:
```lua
...

wezterm.plugin
  .require('https://github.com/yriveiro/wezterm-tabs')
  .apply_to_config(config)

...
```

@example Custom configuration:
```lua
...

wezterm.plugin
  .require('https://github.com/yriveiro/wezterm-tabs')
  .apply_to_config(config) {
    tabs = {
      tab_bar_at_bottom = true,
      hide_tab_bar_if_only_one_tab = false,
      tab_max_width = 32
    },
    ui = {
      tab = {
        zoom_indicator = {
          enabled = true,
          type = 'icon'
        }
      }
    }
  }
)

...
```
]]

---@diagnostic disable: undefined-field

local ipairs = ipairs
local pairs = pairs
local type = type
local assert = assert
local tostring = tostring
local lower = string.lower
local match = string.match
local format = string.format

---@class Config: Wezterm
local wezterm = require 'wezterm'

--- Merges two tables recursively
---@package
---@param t1 table The first table to merge into
---@param t2 table The second table to merge from
---@return table table The merged table
local function tableMerge(t1, t2)
  for k, v in pairs(t2) do
    if type(v) == 'table' then
      if type(t1[k] or false) == 'table' then
        tableMerge(t1[k] or {}, t2[k] or {})
      else
        t1[k] = v
      end
    else
      t1[k] = v
    end
  end
  return t1
end

---@type WeztermTabConfig
local config = {
  tabs = {
    tab_bar_at_bottom = true,
    hide_tab_bar_if_only_one_tab = false,
    tab_max_width = 32,
    unzoom_on_switch_pane = true,
  },
  ui = {
    separators = {
      arrow_solid_left = '\u{e0b0}',
      arrow_solid_right = '\u{e0b2}',
      arrow_thin_left = '\u{e0b1}',
      arrow_thin_right = '\u{e0b3}',
    },
    icons = {
      ['debug'] = wezterm.nerdfonts.cod_debug_console,
      ['bash'] = wezterm.nerdfonts.cod_terminal_bash,
      ['cargo'] = wezterm.nerdfonts.dev_rust,
      ['curl'] = wezterm.nerdfonts.md_waves,
      ['docker'] = wezterm.nerdfonts.linux_docker,
      ['docker-compose'] = wezterm.nerdfonts.linux_docker,
      ['gh'] = wezterm.nerdfonts.dev_github_badge,
      ['git'] = wezterm.nerdfonts.dev_git,
      ['go'] = wezterm.nerdfonts.seti_go,
      ['kubectl'] = wezterm.nerdfonts.linux_docker,
      ['lua'] = wezterm.nerdfonts.seti_lua,
      ['make'] = wezterm.nerdfonts.seti_makefile,
      ['node'] = wezterm.nerdfonts.md_hexagon,
      ['nvim'] = wezterm.nerdfonts.custom_vim,
      ['sudo'] = wezterm.nerdfonts.fa_hashtag,
      ['vim'] = wezterm.nerdfonts.dev_vim,
      ['wget'] = wezterm.nerdfonts.md_arrow_down_box,
      ['zsh'] = wezterm.nerdfonts.dev_terminal,
      ['lazygit'] = wezterm.nerdfonts.dev_github_alt,
    },
    tab = {
      zoom_indicator = {
        enabled = false,
        type = 'icon',
      },
    },
  },
}

--- Safe title parsing with error handling
---@package
---@nodiscard
---@param title string The raw tab title to parse
---@return string process The detected process name
---@return string custom Any custom title text
local function parse_title(title)
  local process, custom = title:match '^(%S+)%s*%-?%s*%s*(.*)$'
  return process or 'unknown', custom or ''
end

--- Returns the title for the tab
---@package
---@nodiscard
---@param tab TabInformation The tab object to get the title for
---@param max_width integer Maximum width for the title
---@return string title Title for the tab
local function tab_title(tab, max_width)
  local title = (tab.tab_title and #tab.tab_title > 0) and tab.tab_title
    or tab.active_pane.title
  local process, custom = parse_title(title)
  local icon = ''

  local proc = string.lower(process)

  if config.ui.icons[proc] then
    icon = (config.ui.icons[proc] or wezterm.nerdfonts.cod_workspace_unknown) .. ' '
  end

  if custom ~= '' then
    title = custom
  end

  title = wezterm.truncate_right(title, max_width - 3)

  return ' ' .. icon .. title .. ' '
end

--- Returns the current tab index
---@package
---@nodiscard
---@param tabs TabInformation[] Array of all tabs
---@param tab TabInformation The tab to find the index for
---@return number tab_index The 1-based index of the tab
local function tab_current_idx(tabs, tab)
  local idx = 0

  for i, t in ipairs(tabs) do
    if t.tab_id == tab.tab_id then
      idx = i
      break
    end
  end

  return idx
end

--- Generates the tab metadata including zoom indicator
---@param idx number The tab index
---@param tab TabInformation The tab object
---@return string The formatted tab metadata
local function tab_current_meta(idx, tab)
  -- Early return if zoom indicator is disabled
  if not config.ui.tab.zoom_indicator.enabled then
    return tostring(idx)
  end

  -- Get pane information once
  local mux_tab = wezterm.mux.get_tab(tab.tab_id)
  local panes = mux_tab:panes_with_info()
  local npanes = #panes

  -- Early return for single pane
  if npanes == 1 then
    return tostring(idx)
  end

  -- Cache subscript characters
  local subscript = {
    [1] = '₁',
    [2] = '₂',
    [3] = '₃',
    [4] = '₄',
    [5] = '₅',
    [6] = '₆',
    [7] = '₇',
    [8] = '₈',
    [9] = '₉',
    [10] = 'x',
  }

  -- Check for zoomed pane
  local is_zoomed = false
  for _, pane in ipairs(panes) do
    if pane.is_zoomed then
      is_zoomed = true
      break
    end
  end

  -- Handle zoomed states
  if is_zoomed and npanes > 1 then
    if config.ui.tab.zoom_indicator.type == 'icon' then
      return ''
    end
    if config.ui.tab.zoom_indicator.type == 'number' then
      local sub = '₍' .. (npanes > 9 and subscript[10] or subscript[npanes]) .. '₎'
      return '' .. sub
    end
  end

  -- Default case: show index with subscript
  local sub = '₍' .. (npanes > 9 and subscript[10] or subscript[npanes]) .. '₎'
  return idx .. sub
end

-- Pre-allocate format tables to reduce table creation
local ACTIVE_FORMAT = {
  { Background = { Color = nil } },
  { Foreground = { Color = nil } },
  { Attribute = { Intensity = 'Bold' } },
  { Text = nil },
  { Background = { Color = nil } },
  { Foreground = { Color = nil } },
  { Text = nil },
  { Background = { Color = nil } },
  { Foreground = { Color = nil } },
  { Text = nil },
}

local INACTIVE_FORMAT = {
  { Background = { Color = nil } },
  { Foreground = { Color = nil } },
  { Text = nil },
  { Background = { Color = nil } },
  { Foreground = { Color = nil } },
  { Text = nil },
  { Background = { Color = nil } },
  { Foreground = { Color = nil } },
  { Text = nil },
}

local M = {}

--- Applies configuration to Wezterm
---@param wezterm_config Config The Wezterm configuration table to modify
---@param opts? WeztermTabConfig Optional configuration overrides
---@return nil
function M.apply_to_config(wezterm_config, opts)
  assert(type(wezterm_config) == 'table', 'wezterm_config must be a table')
  if opts then
    assert(type(opts) == 'table', 'opts must be a table')
  end

  config = tableMerge(config, opts or {})

  wezterm_config.use_fancy_tab_bar = false
  wezterm_config.tab_bar_at_bottom = config.tabs.tab_bar_at_bottom
  wezterm_config.hide_tab_bar_if_only_one_tab = config.tabs.hide_tab_bar_if_only_one_tab
  wezterm_config.tab_max_width = config.tabs.tab_max_width
  wezterm_config.unzoom_on_switch_pane = config.tabs.unzoom_on_switch_pane
end

wezterm.on('format-tab-title', function(tab, tabs, _, wezterm_config, _, max_width)
  local tab_bar = wezterm_config.color_schemes[wezterm_config.color_scheme].tab_bar
  local active_bg = tab_bar.active_tab.bg_color
  local active_fg = tab_bar.active_tab.fg_color
  local inactive_bg = tab_bar.inactive_tab.bg_color
  local inactive_fg = tab_bar.inactive_tab.fg_color
  local background = tab_bar.background

  local title = tab_title(tab, max_width)
  local tab_idx = tab_current_idx(tabs, tab)
  local tab_meta = tab_current_meta(tab_idx, tab)
  local is_last = tab_idx == #tabs

  local tab_text =
    format(' %s %s%s', tab_meta, config.ui.separators.arrow_thin_left, title)

  if tab.is_active then
    ACTIVE_FORMAT[1].Background.Color = active_bg
    ACTIVE_FORMAT[2].Foreground.Color = active_fg
    ACTIVE_FORMAT[4].Text = tab_text
    ACTIVE_FORMAT[5].Background.Color = background
    ACTIVE_FORMAT[6].Foreground.Color = active_bg
    ACTIVE_FORMAT[7].Text = config.ui.separators.arrow_solid_left
    ACTIVE_FORMAT[8].Background.Color = is_last and background or inactive_bg
    ACTIVE_FORMAT[9].Foreground.Color = background
    ACTIVE_FORMAT[10].Text = config.ui.separators.arrow_solid_left
    return ACTIVE_FORMAT
  end

  local next_tab = tabs[tab_idx + 1]
  local next_bg = is_last and background
    or (next_tab.is_active and active_bg or inactive_bg)

  INACTIVE_FORMAT[1].Background.Color = inactive_bg
  INACTIVE_FORMAT[2].Foreground.Color = inactive_fg
  INACTIVE_FORMAT[3].Text = tab_text
  INACTIVE_FORMAT[4].Background.Color = background
  INACTIVE_FORMAT[5].Foreground.Color = inactive_bg
  INACTIVE_FORMAT[6].Text = config.ui.separators.arrow_solid_left
  INACTIVE_FORMAT[7].Background.Color = next_bg
  INACTIVE_FORMAT[8].Foreground.Color = background
  INACTIVE_FORMAT[9].Text = config.ui.separators.arrow_solid_left
  return INACTIVE_FORMAT
end)

return M
