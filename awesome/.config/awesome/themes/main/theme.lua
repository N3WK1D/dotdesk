---------------------------
-- Custom awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local themes_path = string.format("%s/.config/awesome/themes/main/", os.getenv("HOME"))
local wallpaper = "yin-yang.jpg"
local wallpaper_path = themes_path.."wallpaper/"
local icons_path = themes_path.."icons/"

local theme = {}

theme.font          = "sans 8"
theme.opacity       = 0.9

-- Standard colors
theme.color_black      = "#000000"
theme.color_white      = "#ffffff"

-- Custom colors
theme.color_custom_main        = "#29ab87" -- Jungle Green
theme.color_custom_comp        = "#ab294d" -- Brick Red
theme.color_custom_dark        = "#155644" -- Green Pea

theme.useless_gap   = dpi(2)
theme.border_width  = dpi(2)
theme.border_normal = theme.color_custom_dark
theme.border_focus  = theme.color_custom_main
theme.border_marked = theme.color_custom_comp

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|color_white|color_black|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]
theme.notification_font = theme.font
theme.notification_bg = theme.color_black
theme.notification_fg = theme.color_white
--theme.notification_width = 
--theme.notification_height = 
--theme.notification_margin = 
theme.notification_border_color = theme.border_focus
theme.notification_border_width = theme.border_width
theme.notification_opacity = theme.opacity

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = icons_path.."submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- Variables set for theming the hotkeys window:
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
theme.hotkeys_bg = theme.color_black
theme.hotkeys_fg = theme.color_white
theme.hotkeys_border_width = theme.border_width
theme.hotkeys_border_color = theme.border_focus
theme.hotkeys_opacity = theme.opacity
theme.hotkeys_modifiers_fg = theme.color_custom_dark
theme.hotkeys_label_bg = theme.color_white
theme.hotkeys_label_fg = theme.color_black
theme.hotkeys_group_margin = 10
--theme.hotkeys_font = theme.font
--theme.hotkeys_description_font = theme.font

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"


-- Define the image to load
theme.wallpaper = wallpaper_path..wallpaper

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
