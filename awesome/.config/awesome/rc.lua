-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- {{{ Required libraries
local gears = require("gears") -- Standard awesome library
local awful = require("awful") -- Standard awesome library
require("awful.autofocus")
local wibox = require("wibox") -- Widget and layout library
local beautiful = require("beautiful") -- Theme handling library
local naughty = require("naughty") -- Notification library
local menubar = require("menubar") --Menubar library
local layouts = require("utils.layouts") -- Bling library
local keys = require("utils.keys") -- User keys library
local rules = require("utils.rules") -- User rules library
local menu = require("utils.menu") -- App menu library
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")
-- }}}

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions

-- User programs
terminal = "alacritty"
editor = "nvim"

-- Theme selection
local themes = {
	"main"    -- 1
}

theme = themes[1]
beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), theme))

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    layouts.centered,
    awful.layout.suit.max,
    awful.layout.suit.floating,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
awesomemenu = {
   { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "Manual", terminal .. " -e man awesome" },
   { "Config", terminal .. " -e " .. editor .. " " .. awesome.conffile },
   { "Restart", awesome.restart },
   { "Quit", function() awesome.quit() end },
}

systemmenu = {
   { "Lock Screen", "slock" },
   { "Reboot", "loginctl reboot" },
   { "Power Off", "loginctl poweroff" },
}

appimagemenu = {
    { "Bitwarden", "Bitwarden-2022.8.1-x86_64.AppImage" },
    { "Obsidian", "Obsidian-0.15.9.AppImage" },
    { "Session", "session-desktop-linux-x86_64-1.10.0.AppImage" },
}

mymainmenu = menu.build({
    before = {
        { "Awesome", awesomemenu },
        { "System", systemmenu },
        { "AppImages", appimagemenu },
        { "Terminal", terminal }
    }
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Screen
local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)
    -- Each screen has its own tag table
    awful.tag({ "1", "2", "3", "4" }, s, awful.layout.layouts[1])
end)

-- Set master client to 60% of screen
master_width = 0.6
beautiful.master_width_factor = master_width
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Autostart
awful.spawn.with_shell("$HOME/.config/awesome/utils/autostart.sh")
