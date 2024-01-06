local bling = require("modules.bling")
local awful = require("awful")
local theme = require("default.theme")

bling.widget.task_preview.enable({
	x = 20,
	y = 20,
	height = 200,
	width = 200,
	placement_fn = function(c)
		awful.placement.top_left(c, {
			margins = {
				top = 45,
				left = 270,
			},
		})
	end,
})
