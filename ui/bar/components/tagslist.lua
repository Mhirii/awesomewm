local awful = require("awful")
local wibox = require("wibox")

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

local function update_callback(self, c3, index)
	self:get_children_by_id("index_role")[1].markup = "<b> " .. index .. " </b>"
end

local function tags(s)
	return awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		layout = {
			spacing = 2,
			spacing_widget = {
				color = "#dddddd",
				widget = wibox.widget.separator,
			},
			layout = wibox.layout.fixed.horizontal,
		},
		widget_template = {
			{
				{
					{
						{
							id = "index_role",
							widget = wibox.widget.textbox,
						},
						margins = 4,
						widget = wibox.container.margin,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left = 4,
				right = 4,
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
			-- Add support for hover colors and an index label
			create_callback = create_callback, --luacheck: no unused args
			update_callback = update_callback,
		},
		buttons = taglist_buttons,
	})
end
return tags
