---@diagnostic disable: undefined-global
local awful = require("awful")
local helpers = require("helpers")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local bling = require("modules.bling")

local function enable_tag_preview(self, c3)
	self:connect_signal("mouse::enter", function()
		-- if #c3:clients() > 0 then
		awesome.emit_signal("bling::tag_preview::update", c3)
		awesome.emit_signal("bling::tag_preview::visibility", s, true)
		-- end
	end)
	self:connect_signal("mouse::leave", function()
		awesome.emit_signal("bling::tag_preview::visibility", s, false)
	end)
end

local function update_tags(self, index, s)
	local markup_role = self:get_children_by_id("markup_role")[1]

	local found = false
	local i = 1

	while i <= #s.selected_tags do
		if s.selected_tags[i].index == index then
			found = true
		end
		i = i + 1
	end

	if found then
		markup_role.image = gears.color.recolor_image(beautiful.selected_tag_format, beautiful.taglist_fg_focus)
	else
		markup_role.image = gears.color.recolor_image(beautiful.normal_tag_format, beautiful.taglist_fg)
		for _, c in ipairs(client.get(s)) do
			for _, t in ipairs(c:tags()) do
				if t.index == index then
					markup_role.image =
						gears.color.recolor_image(beautiful.occupied_tag_format, beautiful.taglist_fg_occupied)
				end
			end
		end
	end
end

local function get_taglist(s)
	return awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		style = {
			shape = gears.shape.powerline,
		},
		layout = {
			spacing = -12,
			spacing_widget = {
				color = "#dddddd",
				shape = gears.shape.powerline,
				widget = wibox.widget.separator,
			},
			layout = wibox.layout.fixed.horizontal,
		},
		widget_template = {
			{
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
						bg = "#dddddd",
						shape = gears.shape.circle,
						widget = wibox.container.background,
					},
					{
						{
							id = "icon_role",
							widget = wibox.widget.imagebox,
						},
						margins = 2,
						widget = wibox.container.margin,
					},
					{
						id = "text_role",
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left = 18,
				right = 18,
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
			-- Add support for hover colors and an index label
			create_callback = function(self, c3, index, objects) --luacheck: no unused args
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
			end,
			update_callback = function(self, c3, index, objects) --luacheck: no unused args
				self:get_children_by_id("index_role")[1].markup = "<b> " .. index .. " </b>"
			end,
		},
		buttons = taglist_buttons,
	})
end

return get_taglist
