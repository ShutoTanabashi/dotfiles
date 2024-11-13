-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- Loading environment dependent settings
local envcfg = require 'envcfg'
local keybinds = require 'keybinds'

-- This table will hold the configuration.
local config = {
	color_scheme = 'Smyck',
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
local all_keys = keybinds.add_local_keys(keybinds.keys, envcfg)
config.keys = all_keys

-- For Windows
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  local windows = require 'windows'
  config.default_prog = windows.prog_win
end

-- and finally, return the configuration to wezterm
return config
