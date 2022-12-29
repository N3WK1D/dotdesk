local awful = require("awful")
local naughty = require("naughty")
local gears = require("gears")
local menubar = require("menubar")
--local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
local naughty = require("naughty") -- Notification

local keys = {}

-- {{{ Modifier keys
modkey = "Mod4"
altkey = "Mod1"
-- }}}

-- {{{ Mouse bindings
keys.globalbuttons = gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end)
)

keys.clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set buttons
root.buttons(keys.globalbuttons)
-- }}}

-- {{{ Key bindings
keys.globalkeys = gears.table.join(

    -- Awesome commands
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Control" }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey, "Control" }, "p", function () awful.spawn("loginctl poweroff") end,
              {description = "power off", group = "awesome"}),
    awful.key({ modkey, "Control", "Shift" }, "p", function () awful.spawn("loginctl reboot") end,
              {description = "reboot", group = "awesome"}),
    awful.key({ modkey, "Control" }, "x", function () awful.spawn("slock") end,
              {description = "lock", group = "awesome"}),
              
    -- Standard commands
    awful.key({ modkey }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),
    awful.key({ modkey }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey }, "r", function () awful.spawn("rofi -show combi") end,
              {description = "show rofi combi", group = "awesome"}),
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show menubar", group = "awesome"}),

    -- Tag browsing
    awful.key({ modkey }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    -- Focus control
    awful.key({ modkey }, "j", function () awful.client.focus.byidx( 1) end,
        {description = "focus next by index", group = "client"}),
    awful.key({ modkey }, "k", function () awful.client.focus.byidx(-1) end,
        {description = "focus previous by index", group = "client"}),
    awful.key({ modkey }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey }, "Tab", function () awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "return to previous client", group = "client"}),

    -- Index control
    awful.key({ modkey }, "l", function () awful.client.swap.byidx( 1) end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey }, "h", function () awful.client.swap.byidx(-1) end,
              {description = "swap with previous client by index", group = "client"}),

    -- Master client control
    awful.key({ modkey, "Control" }, "l", function () awful.tag.incmwfact( 0.05) end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey, "Control" }, "h", function () awful.tag.incmwfact(-0.05) end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Control" }, "space",
        function ()
            if awful.screen.focused().selected_tag.master_width_factor == master_width then
                awful.screen.focused().selected_tag.master_width_factor = 0.5
            elseif awful.screen.focused().selected_tag.master_width_factor == 0.5 then
                awful.screen.focused().selected_tag.master_width_factor = master_width
            end
        end,
              {description = "set master width factor to 50%", group = "layout"}),

    -- Column control 
    awful.key({ modkey, "Control" }, "k", function () awful.tag.incncol( 1, nil, true) end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "j", function () awful.tag.incncol(-1, nil, true) end,
              {description = "decrease the number of columns", group = "layout"}),

    -- Layout control
    awful.key({ modkey }, "space", function () awful.layout.inc( 1) end,
              {description = "cycle layouts forward", group = "layout"}),
    awful.key({ modkey, "Shift" }, "space", function () awful.layout.inc(-1) end,
              {description = "cycle layouts backward", group = "layout"}),

    -- Screen selection
    awful.key({ modkey, "Control" }, "Right", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "Left", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),

    -- Restore minimized client
    awful.key({ modkey, "Shift" }, "z", function () local c = awful.client.restore()
            if c then
                c:emit_signal("request::activate", "key.unminimize", {raise = true})
            end
        end,
              {description = "restore minimized", group = "client"}),

    -- Toggle conky visibility
    awful.key({ modkey }, "`",
        function ()
            local conky = function (c) return awful.rules.match(c, {class = "conky"}) end
            local view
            for c in awful.client.iterate(conky) do
                view = c
            end
            if view and view.hidden == false then
                view.hidden = true
            elseif view and view.hidden == true then
                view.hidden = false
            end
        end,
            {description = "toggle conky visibility", group = "launcher"}),

   -- Clear notifications
    awful.key({ modkey }, "Backspace", function() naughty.destroy_all_notifications() end,
              {description = "clear notifications", group = "hotkeys"})
) 

keys.clientkeys = gears.table.join(
    awful.key({ modkey }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
              {description = "fullscreen", group = "client"}),
    awful.key({ modkey }, "q",      function (c) c:kill() end,
              {description = "close", group = "client"}),
    awful.key({ modkey }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey }, "o",      function (c) c:move_to_screen() end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey }, "t",      function (c) c.ontop = not c.ontop end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey }, "z", function (c) c.minimized = true end ,
              {description = "minimize", group = "client"}),
    awful.key({ modkey }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end,
              {description = "(un)maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    keys.globalkeys = gears.table.join(keys.globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

-- Set keys
root.keys(keys.globalkeys)
-- }}}

return keys
