local gears = require("gears")
local wibox = require("wibox")

---@diagnostic disable-next-line: unused-local
function ROUNDED_RECT(cr, width, height, radius)
	gears.shape.rounded_rect(cr, width, height, 2)
end

function margins(widget, top, left, botom, right)
	return {
		widget,
		widget = wibox.container.margin,
		top = top,
		left = left,
		right = right,
		bottom = botom,
	}
end

function container_border(widget, bg, fg, border_color, shape)
	return {
		widget,
		widget = wibox.container.background,
		fg = fg,
		bg = bg,
		border_radius = 1,
		border_color = border_color,
		border_width = 1,
		shape = shape,
	}
end

return {
	rounded_rect = ROUNDED_RECT,
	margins = margins,
	container_border = container_border,
}
