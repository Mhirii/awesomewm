local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful").xresources.apply_dpi
local helpers = require("helpers")
local theme = require("default.theme")
local shapes = require("theme.decay.shapes")

local bluetooth = require("ui.bar.components.bluetooth")
local layoutbox = require("ui.bar.components.layoutbox")
local promptbox = require("ui.bar.components.promptbox")
local tagslist = require("ui.bar.components.tagslist")
local tasklist = require("ui.bar.components.tasklist")
local textclock = require("ui.bar.components.time")
local wifi = require("ui.bar.components.wifi")

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
		height = 38,
		-- margins  = { top = dpi(10), bottom = dpi(10), left = dpi(10), right = dpi(10) },
		screen = s,
		widget = {
			layout = wibox.layout.align.horizontal,
			expand = "inside",
			{ -- Left widgets
				layout = wibox.layout.fixed.horizontal,
				shapes.margins(mylauncher, 8, 8, 8, 8),
				shapes.margins({
					shapes.margins(s.taglist, 2, 2, 2, 2),
					widget = wibox.container.background,
					fg = theme.fg_normal,
					bg = theme.black,
					border_radius = 1,
					border_color = theme.light_black,
					border_width = 1,
					shape = shapes.rounded_rect,
				}, 4, 8, 4, 4),
				s.promptbox,
			},

			{ -- Middle widget
				s.mytasklist,
				layout = wibox.layout.flex.horizontal,
				widget = wibox.container.place,
				fill_horizontal = true,
				valign = "center",
				halign = "center",
				bg = theme.black,
				fg = theme.fg_normal,
			},

			{ -- Right widgets
				layout = wibox.layout.fixed.horizontal,
				shapes.margins({
					shapes.margins(
						wibox.widget.systray({
							base_size = 4,
						}),
						4,
						4,
						4,
						4
					),
					widget = wibox.container.background,
					fg = theme.fg_normal,
					bg = theme.black,
					shape = shapes.rounded_rect,
				}, 4, 4, 4, 4),
				shapes.margins(mytextclock, 4, 4, 4, 4),
				shapes.margins(s.layoutbox, 4, 4, 4, 4),
			},
		},
	})
end)

-- }}}
