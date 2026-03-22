-- Key binding settings for wezterm
local wezterm = require 'wezterm'
local act = wezterm.action

local M = {}

local function build_keys(envcfg)
  return {
    -- Pane control
    -- These keymap are referenced tmux.
    {
      key = '"',
      mods = 'LEADER|SHIFT',
      action = act.SplitVertical {},
    },
    {
      key = '%',
      mods = 'LEADER|SHIFT',
      action = act.SplitHorizontal {},
    },
    {
      key = 'x',
      mods = 'LEADER',
      action = act.CloseCurrentPane { confirm = true },
    },
    {
      key = 'c',
      mods = 'LEADER',
      action = act.SpawnTab 'CurrentPaneDomain',
    },
    {
      -- Add new tab at $HOME
      key = 'C',
      mods = 'LEADER|SHIFT',
      action = act.SpawnCommandInNewTab {
        cwd = wezterm.home_dir,
      },
    },
    {
      key = 'n',
      mods = 'LEADER',
      action = act.ActivateTabRelative(1),
    },
    {
      key = 'p',
      mods = 'LEADER',
      action = act.ActivateTabRelative(-1),
    },
    -- The keymap for moving pane are option + hjkl.
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
    {
      -- Open new tab at dotfiles
      key = ',',
      mods = 'LEADER',
      action = act.SpawnCommandInNewTab {
        cwd = envcfg.path_dotfiles,
      },
    },
  }
end

function M.apply_to(config, envcfg)
  config.leader = { key = 't', mods = 'CTRL', timeout_milliseconds = 1000 }
  config.keys = build_keys(envcfg)
end

return M
