local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful").xresources.apply_dpi
local helpers = require("helpers")

local bluetooth = require("ui.bar.components.bluetooth")
local layoutbox = require("ui.bar.components.layoutbox")
local promptbox = require("ui.bar.components.promptbox")
local tagslist = require("ui.bar.components.tagslist")
local tasklist = require("ui.bar.components.tasklist")
local textclock = require("ui.bar.components.time")
local wifi = require("ui.bar.components.wifi")

-- TODO: Add volume, cpu , memory and logout widgets
-- local volume     = require("ui.bar.widgets.volume")
-- local cpu        = require("ui.bar.widgets.cpu")
-- local memory     = require("ui.bar.widgets.memory")
-- local logout     = require("ui.bar.widgets.logout")

-- {{{ Wibar

-- Create a textclock widget
local mytextclock = textclock

---@diagnostic disable-next-line: undefined-global
screen.connect_signal("request::desktop_decoration", function(s)
	-- Each screen has its own tag table.
	awful.tag({ "1", "2", "3", "4", "5", "6" }, s, awful.layout.layouts[1])
	s.promptbox = promptbox
	s.layoutbox = layoutbox(s)
	s.taglist = tagslist(s)
	s.mytasklist = tasklist(s)

	-- Create the wibox
	s.mywibox = awful.wibar({
		position = "top",
		-- margins  = { top = dpi(10), bottom = dpi(10), left = dpi(10), right = dpi(10) },
		screen = s,
		widget = {
			layout = wibox.layout.align.horizontal,
			{ -- Left widgets
				layout = wibox.layout.fixed.horizontal,
				mylauncher,
				s.taglist,
				s.promptbox,
			},
			s.mytasklist, -- Middle widget
			{ -- Right widgets
				layout = wibox.layout.fixed.horizontal,
				wibox.widget.systray({
					base_size = 4,
				}),
				mytextclock,
				s.layoutbox,
			},
		},
	})
end)

-- }}}
