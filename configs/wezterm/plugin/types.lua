---@alias ZoomIndicatorType "icon" | "number"

---@class WeztermTabConfig
---@field tabs TabConfiguration Configuration for tab bar behavior
---@field ui UIConfiguration Configuration for visual elements

---@class TabConfiguration
---@field tab_bar_at_bottom boolean Whether to place the tab bar at the bottom of the window
---@field hide_tab_bar_if_only_one_tab boolean Whether to hide the tab bar when only one tab exists
---@field tab_max_width number Maximum width of a tab in characters
---@field unzoom_on_switch_pane boolean Whether to unzoom when switching between panes

---@class UIConfiguration
---@field separators SeparatorConfig Visual separators used in the tab bar
---@field icons table<string, string> Process-specific icons for tabs
---@field tab TabUIConfig Tab-specific UI configuration

---@class SeparatorConfig
---@field arrow_solid_left string Unicode character for solid left arrow
---@field arrow_solid_right string Unicode character for solid right arrow
---@field arrow_thin_left string Unicode character for thin left arrow
---@field arrow_thin_right string Unicode character for thin right arrow

---@class TabUIConfig
---@field zoom_indicator ZoomIndicatorConfig Configuration for the zoom indicator

---@class ZoomIndicatorConfig
---@field enabled boolean Whether to show zoom indicators
---@field type ZoomIndicatorType Type of zoom indicator to display
