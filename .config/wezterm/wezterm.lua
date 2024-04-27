local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.window_padding = {
  left = "0.5cell",
  right = 0,
  top = "0.5cell",
  bottom = 0,
}

local act = wezterm.action
local terafox = wezterm.color.get_builtin_schemes()['terafox']
-- config.color_scheme = "terafox"
-- config.color_scheme = "carbonfox"
-- config.font = wezterm.font 'DejaVuSansM Nerd Font'
config.font = wezterm.font('DejaVuSansM Nerd Font', { weight = 'Medium', style = 'Normal'})
config.font_size = 11
config.colors = {
  cursor_bg = "lightgrey",
}
config.window_background_opacity = 1.0
config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"
config.enable_wayland = true
-- config.freetype_load_flags = "NO_HINTING"
-- config.front_end = "OpenGL"

-- config.key_tables = {
  -- activate_pane = {
  --   { key = 'h', }
  -- }
-- }

return config
