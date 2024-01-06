local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local theme = require("theme.decay.theme")
require("theme.decay.shapes")
require("theme.decay.styles")

local gears = require("gears")

local function create_callback(self, c3, index, s)
	self:get_children_by_id("index_role")[1].markup = "<b> " .. index .. " </b>"
	self:connect_signal("mouse::enter", function()
		-- BLING: Only show widget when there are clients in the tag
		if #c3:clients() > 0 then
			-- BLING: Update the widget with the new tag
			awesome.emit_signal("bling::tag_preview::update", c3)
			-- BLING: Show the widget
			awesome.emit_signal("bling::tag_preview::visibility", s, true)
		end

		if self.bg ~= "#ff0000" then
			self.backup = self.bg
			self.has_backup = true
		end
		self.bg = "#ff0000"
	end)
	self:connect_signal("mouse::leave", function()
		-- BLING: Turn the widget off
		awesome.emit_signal("bling::tag_preview::visibility", s, false)

		if self.has_backup then
			self.bg = self.backup
		end
	end)
end

local function update_callback(self, c3, index, objects)
	self:get_children_by_id("index_role")[1].markup = "<b> " .. index .. " </b>"
	-- local background_container = self:get_children_by_id("bg_1")[1]
	-- local t = objects[1]
	-- if t.selected then
	-- 	background_container.fg = theme.fg_focus -- Apply focused background color
	-- else
	-- 	background_container.fg = theme.fg_normal -- Apply default background color
	-- end
end

local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

local function tags(s, cr)
	return awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		layout = {
			spacing = 2,
			spacing_widget = {
				color = theme.black,
				widget = wibox.widget.separator,
			},
			layout = wibox.layout.flex.horizontal,
		},
		widget_template = {
			{
				{
					{
						{
							id = "index_role",
							widget = wibox.widget.textbox,
							opacity = 0,
						},
						widget = wibox.container.margin,
						margins = -16,
					},
					{
						{
							id = "text_role",
							widget = wibox.widget.textbox,
						},
						widget = wibox.container.margin,
						left = 12,
						right = 12,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				id = "bg_1",
				left = 2,
				right = 2,
				widget = wibox.container.background,
			},
			id = "background_role",
			widget = wibox.container.background,
			margins = 4,

			-- Add support for hover colors and an index label
			create_callback = create_callback, --luacheck: no unused args
			update_callback = update_callback,
		},
		buttons = taglist_buttons,
	})
end

return tags
