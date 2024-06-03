-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- Loading environment dependent settings
local envcfg = require 'envcfg'

-- This table will hold the configuration.
local config = {
	color_scheme = 'kanagawabones',
	font = envcfg.font,
	font_size = envcfg.font_size,
	use_ime = true,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,
	enable_scroll_bar = true,
}

--[[
--In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end
--]]

config.keys = {
  -- Pane control
  {
	key = 'c',
	mods = 'CTRL|SHIFT',
	action = act.CloseCurrentPane {confirm = true},
  },
  -- For macOS, the keymap for moving pane are option + hjkl.
  {
    key = 'h',
    mods = 'ALT',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'j',
    mods = 'ALT',
    action = act.ActivatePaneDirection 'Down',
  },
  {
    key = 'k',
    mods = 'ALT',
    action = act.ActivatePaneDirection 'Up',
  },
  {
    key = 'l',
    mods = 'ALT',
    action = act.ActivatePaneDirection 'Right',
  },
}

-- and finally, return the configuration to wezterm
return config
