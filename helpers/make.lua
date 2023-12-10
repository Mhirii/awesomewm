-- Highly inspired by AlphaTechnolog
-- ────────────────────────────────────────────────────────────────────────── --
--               credits to https://github.com/AlphaTechnolog               --
-- ────────────────────────────────────────────────────────────────────────── --

local gears     = require 'gears'
local wibox     = require 'wibox'
local awful     = require 'awful'
local beautiful = require 'beautiful'
local dpi       = beautiful.xresources.apply_dpi

local make      = {}

-- add hover support to wibox.container.background-based elements
function make.add_hover(element, bg, hbg)
  element:connect_signal('mouse::enter', function(self)
    self.bg = hbg
  end)
  element:connect_signal('mouse::leave', function(self)
    self.bg = bg
  end)
end

-- create a rounded rect using a custom radius
function make.roundedrect(radius)
  radius = radius or dpi(7)
  return function(cr, w, h)
    return gears.shape.rounded_rect(cr, w, h, radius)
  end
end

-- create a simple rounded-like button with hover support
function make.btn(template, bg, hbg, radius)
  local button = wibox.widget {
    {
      template,
      margins = dpi(7),
      widget = wibox.container.margin,
    },
    bg = bg,
    widget = wibox.container.background,
    shape = make.roundedrect(radius),
  }

  if bg and hbg then
    make.add_hover(button, bg, hbg)
  end

  return button
end

-- add a list of buttons using :add_button to `widget`.
function make.add_buttons(widget, buttons)
  for _, button in ipairs(buttons) do
    widget:add_button(button)
  end
end

-- make a rounded container for make work the antialiasing.
function make.roundedcontainer(template, bg)
  return wibox.widget {
    template,
    shape = make.roundedrect(),
    bg = bg,
    widget = wibox.container.background,
  }
end

-- make an awful.popup that's used to replace the native AwesomeWM tooltip component
function make.popup_tooltip(text, placement)
  local ret = {}

  ret.widget = wibox.widget {
    {
      {
        id = 'image',
        image = beautiful.hints_icon,
        forced_height = dpi(12),
        forced_width = dpi(12),
        halign = 'center',
        valign = 'center',
        widget = wibox.widget.imagebox,
      },
      {
        id = 'text',
        markup = text or '',
        align = 'center',
        widget = wibox.widget.textbox,
      },
      spacing = dpi(7),
      layout = wibox.layout.fixed.horizontal,
    },
    margins = dpi(12),
    widget = wibox.container.margin,
    set_text = function(self, t)
      self:get_children_by_id('text')[1].markup = t
    end,
    set_image = function(self, i)
      self:get_children_by_id('image')[1].image = i
    end
  }

  ret.popup = awful.popup {
    visible = false,
    shape = make.roundedrect(),
    bg = beautiful.bg_normal .. '00',
    fg = beautiful.fg_normal,
    ontop = true,
    placement = placement or awful.placement.centered,
    screen = awful.screen.focused(),
    widget = make.roundedcontainer(ret.widget, beautiful.bg_normal),
  }

  local self = ret.popup

  function ret.show()
    self.screen = awful.screen.focused()
    self.visible = true
  end

  function ret.hide()
    self.visible = false
  end

  function ret.toggle()
    if not self.visible and self.screen ~= awful.screen.focused() then
      self.screen = awful.screen.focused()
    end
    self.visible = not self.visible
  end

  function ret.attach_to_object(object)
    object:connect_signal('mouse::enter', ret.show)
    object:connect_signal('mouse::leave', ret.hide)
  end

  return ret
end

return make
