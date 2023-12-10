local awful = require("awful")
local beautiful = require("beautiful")
local userapps = require("user_settings").apps

myawesomemenu = {
  { "hotkeys",     function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
  { "manual",      userapps.terminal .. " -e man awesome" },
  { "edit config", userapps.editor_cmd .. " " .. awesome.conffile },
  { "restart",     awesome.restart },
  { "quit",        function() awesome.quit() end },
}

mymainmenu = awful.menu({
  items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
    { "open terminal", userapps.terminal }
  }
})

mylauncher = awful.widget.launcher({
  image = beautiful.awesome_icon,
  menu = mymainmenu
})
