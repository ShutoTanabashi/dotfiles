-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- Loading environment dependent settings
local envcfg = require 'envcfg'
local keybinds = require 'keybinds'

local config = wezterm.config_builder()
local env = envcfg.load()

config.color_scheme = 'Smyck'
config.colors = {
  -- IME background color
  compose_cursor = 'none',
}
config.inactive_pane_hsb = {
  brightness = 0.5,
}
config.use_ime = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.enable_scroll_bar = true
config.front_end = 'WebGpu'

envcfg.apply_to(config, env)
keybinds.apply_to(config, env)

-- For Windows
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  local windows = require 'windows'
  windows.apply_to(config)
end

-- and finally, return the configuration to wezterm
return config
