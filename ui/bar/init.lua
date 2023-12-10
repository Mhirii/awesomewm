local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local dpi       = require("beautiful").xresources.apply_dpi
local helpers   = require("helpers")

-- require("ui.bar.components.systray")

local bluetooth = require("ui.bar.components.bluetooth")
local layoutbox = require("ui.bar.components.layoutbox")
local promptbox = require("ui.bar.components.promptbox")
local tagslist  = require("ui.bar.components.tagslist")
local tasklist  = require("ui.bar.components.tasklist")
local textclock = require("ui.bar.components.time")
local wifi      = require("ui.bar.components.wifi")

-- TODO: Add volume, cpu , memory and logout widgets
-- local volume     = require("ui.bar.widgets.volume")
-- local cpu        = require("ui.bar.widgets.cpu")
-- local memory     = require("ui.bar.widgets.memory")
-- local logout     = require("ui.bar.widgets.logout")

-- {{{ Wibar


-- Create a textclock widget
local mytextclock = textclock


screen.connect_signal("request::desktop_decoration",
  function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6" }, s, awful.layout.layouts[1])
    s.promptbox = promptbox
    s.layoutbox = layoutbox(s)
    s.taglist = tagslist(s)
    s.mytasklist = tasklist(s)

    local tray_dispatcher = wibox.widget {
      image = beautiful.tray_chevron_up,
      forced_height = 14,
      forced_width = 14,
      valign = 'center',
      halign = 'center',
      widget = wibox.widget.imagebox,
    }

    local tray_dispatcher_tooltip = helpers.make.popup_tooltip('Press to toggle the systray panel', function(d)
      return awful.placement.bottom_right(d, {
        margins = {
          bottom = beautiful.bar_height + beautiful.useless_gap * 2,
          right = beautiful.useless_gap * 33,
        }
      })
    end)

    tray_dispatcher:add_button(awful.button({}, 1, function()
      awesome.emit_signal('tray::toggle')
      tray_dispatcher_tooltip.hide()

      if s.tray.popup.visible then
        tray_dispatcher.image = beautiful.tray_chevron_down
      else
        tray_dispatcher.image = beautiful.tray_chevron_up
      end
    end))

    tray_dispatcher_tooltip.attach_to_object(tray_dispatcher)

    local function mkcontainer(template)
      return wibox.widget {
        template,
        left = dpi(8),
        right = dpi(8),
        top = dpi(6),
        bottom = dpi(6),
        widget = wibox.container.margin,
      }
    end
    -- Create the wibox
    s.mywibox = awful.wibar {
      position = "top",
      -- margins  = { top = dpi(10), bottom = dpi(10), left = dpi(10), right = dpi(10) },
      screen   = s,
      widget   = {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
          layout = wibox.layout.fixed.horizontal,
          mylauncher,
          s.taglist,
          s.promptbox,
        },
        s.mytasklist, -- Middle widget
        {             -- Right widgets
          layout = wibox.layout.fixed.horizontal,
          wibox.widget.systray(),
          mytextclock,
          s.layoutbox,
        },
        {
          tray_dispatcher,
          right = dpi(5),
          widget = wibox.container.margin,
        },
      }
    }
  end)

-- }}}
