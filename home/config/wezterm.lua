-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()
local act = wezterm.action
-- This is where you actually apply your config choices
-- Spawn nushell
local home = os.getenv("HOME")
config.default_prog = { home .. '/.nix-profile/bin/nu' }
-- For example, changing the color scheme:
config.color_scheme = 'Default (dark) (terminal.sexy)'

config.keys = {
  { key = 'h',          mods = 'CTRL|SUPER',  action = act.ActivateTabRelative(-1) },
  { key = 'l',          mods = 'CTRL|SUPER',  action = act.ActivateTabRelative(1) },
  { key = 'LeftArrow',  mods = 'CTRL|SUPER',  action = act.ActivateTabRelative(-1) },
  { key = 'RightArrow', mods = 'CTRL|SUPER',  action = act.ActivateTabRelative(1) },
  { key = 'h',          mods = 'SHIFT|SUPER', action = act.ActivatePaneDirection 'Left' },
  { key = 'l',          mods = 'SHIFT|SUPER', action = act.ActivatePaneDirection 'Right' },
  { key = 'k',          mods = 'SHIFT|SUPER', action = act.ActivatePaneDirection 'Up' },
  { key = 'j',          mods = 'SHIFT|SUPER', action = act.ActivatePaneDirection 'Down' },
  { key = 'LeftArrow',  mods = 'SHIFT|SUPER', action = act.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'SHIFT|SUPER', action = act.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'SHIFT|SUPER', action = act.ActivatePaneDirection 'Up' },
  { key = 'DownArrow',  mods = 'SHIFT|SUPER', action = act.ActivatePaneDirection 'Down' },
  { key = 'x',          mods = 'SUPER',       action = act.CloseCurrentPane { confirm = false } },

}

-- config.set_environment_variables = {
--   XDG_CONFIG_HOME = '~/Library/Application Support',
--   XDG_DATA_HOME = '~/Library/Application Support'
-- }

-- config.key_tables = {
-- Defines the keys that are active in our resize-pane mode.
-- Since we're likely to want to make multiple adjustments,
-- we made the activation one_shot=false. We therefore need
-- to define a key assignment for getting out of this mode.
-- 'resize_pane' here corresponds to the name="resize_pane" in
-- the key assignments above.
-- resize_pane = {
--   { key = 'LeftArrow', action = act.AdjustPaneSize { 'Left', 1 } },
--   { key = 'h', action = act.AdjustPaneSize { 'Left', 1 } },

--   { key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 1 } },
--   { key = 'l', action = act.AdjustPaneSize { 'Right', 1 } },

--   { key = 'UpArrow', action = act.AdjustPaneSize { 'Up', 1 } },
--   { key = 'k', action = act.AdjustPaneSize { 'Up', 1 } },

--   { key = 'DownArrow', action = act.AdjustPaneSize { 'Down', 1 } },
--   { key = 'j', action = act.AdjustPaneSize { 'Down', 1 } },

--   -- Cancel the mode by pressing escape
--   { key = 'Escape', action = 'PopKeyTable' },
-- },

-- Defines the keys that are active in our activate-pane mode.
-- 'activate_pane' here corresponds to the name="activate_pane" in
-- the key assignments above.
-- activate_pane = {
-- { key = 'LeftArrow', action = act.ActivatePaneDirection 'Left' },
-- { key = 'h', action = act.ActivatePaneDirection 'Left' },
-- { key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },
-- { key = 'l', action = act.ActivatePaneDirection 'Right' },

-- { key = 'UpArrow', action = act.ActivatePaneDirection 'Up' },
-- { key = 'k', action = act.ActivatePaneDirection 'Up' },

-- { key = 'DownArrow', action = act.ActivatePaneDirection 'Down' },
-- { key = 'j', action = act.ActivatePaneDirection 'Down' },
-- },
-- }
-- and finally, return the configuration to wezterm
return config
