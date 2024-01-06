local beautiful = require("beautiful")
local theme = require("theme.decay.theme")
local myshapes = require("theme.decay.shapes")
local rounded_rect = myshapes.rounded_rect

--          ╭─────────────────────────────────────────────────────────╮
--          │                         Taglist                         │
--          ╰─────────────────────────────────────────────────────────╯
beautiful.taglist_fg_focus = theme.fg_focus
beautiful.taglist_bg_focus = theme.dimblack
beautiful.taglist_fg_urgent = theme.red
beautiful.taglist_bg_urgent = theme.black
beautiful.taglist_shape = rounded_rect
beautiful.taglist_shape_border_width = 0
beautiful.taglist_shape_border_color = theme.black
beautiful.taglist_shape_border_color_focus = theme.grey
beautiful.taglist_shape_border_color_urgent = theme.red

beautiful.taglist_bg_occupied = theme.black
beautiful.taglist_fg_occupied = theme.fg_normal
beautiful.taglist_bg_empty = theme.black
beautiful.taglist_fg_empty = theme.fg_normal
