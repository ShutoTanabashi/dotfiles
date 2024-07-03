-- Pull in the wezterm API
-- local wezterm = require 'wezterm'

-- Loading environment dependent settings
local envcfg = require 'envcfg'
local keybinds = require 'keybinds'

-- This table will hold the configuration.
local config = {
	color_scheme = 'kanagawabones',
	font = envcfg.font,
	font_size = envcfg.font_size,
	use_ime = true,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,
	enable_scroll_bar = true,
	enable_wayland = envcfg.enable_wayland,
}

--[[
--In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end
--]]

config.leader = keybinds.leader
config.keys = keybinds.keys

-- and finally, return the configuration to wezterm
return config
