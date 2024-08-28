-- Import the wezterm module
local wezterm = require("wezterm")
-- Creates a config object which we will be adding our config to
local config = wezterm.config_builder()

config.default_prog = {"/opt/homebrew/bin/fish"}

-- (This is where our config will go)
config.color_scheme = "Poimandres"
config.font = wezterm.font({ family = "BlexMono Nerd Font" })
config.font_size = 13

-- Configure window close behavior
config.window_close_confirmation = 'NeverPrompt'
config.exit_behavior = "Close"
config.quit_when_all_windows_are_closed = false

-- setup tab bar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true


-- Slightly transparent and blurred background
-- config.window_background_opacity = 0.9
-- config.macos_window_background_blur = 30

-- Inactive panes should be dimmer
config.inactive_pane_hsb = {
  brightness = 0.5,
  saturation = 0.7
}

-- Removes the title bar, leaving only the tab bar. Keeps
-- the ability to resize by dragging the window's edges.
-- On macOS, 'RESIZE|INTEGRATED_BUTTONS' also looks nice if
-- you want to keep the window controls visible and integrate
-- them into the tab bar.
-- config.window_decorations = "RESIZE"
-- Sets the font for the window frame (tab bar)
config.window_frame = {
	-- Berkeley Mono for me again, though an idea could be to try a
	-- serif font here instead of monospace for a nicer look?
	font = wezterm.font({ family = "BlexMono Nerd Font", weight = "Bold" }),
	font_size = 12,
}

-- Configured colors for Poimandres
local tab_bar_colors = {
  background = "#1B1E28",
  new_tab = {
    bg_color = "#1B1E28",
    fg_color = "#E4F0FB",
  },
  active_tab = {
    bg_color = "#1B1E28",
    fg_color = "#E4F0FB",
    intensity = "Bold"
  },
  inactive_tab = {
    bg_color = "#1B1E28",
    fg_color = "#506477"
  }
}
config.colors = {
  tab_bar = tab_bar_colors
}

config.window_padding = {
  left = 16,
  right = 16,
  top = 16,
  bottom = 0
}

config.keys = {
  {
    key = 'w',
    mods = 'CMD',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  {
    key = 'd',
    mods = 'CMD',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'd',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'LeftArrow',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'RightArrow',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
  {
    key = 'UpArrow',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'DownArrow',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  -- Clears the scrollback and viewport, and then sends CTRL-L to ask the
  -- shell to redraw its prompt
  {
    key = 'k',
    mods = 'CMD',
    action = wezterm.action.Multiple {
      wezterm.action.ClearScrollback 'ScrollbackAndViewport',
--      wezterm.action.SendKey { key = 'L', mods = 'CTRL' },
    },
  },
  {
    key = 'w',
    mods = 'CMD',
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
}

config.mouse_bindings = {
  -- window dragging
  {
    event = { Down = { streak = 1, button = 'Left' } },
    mods = 'SUPER',
    action = wezterm.action.StartWindowDrag,
    mouse_reporting = true
  },
}

-- Returns our config to be evaluated. We must always do this at the bottom of this file
return config
