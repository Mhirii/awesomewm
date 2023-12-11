local awful = require("awful")

awful.keyboard.append_global_keybindings({

  awful.key({ modkey }, "bracketright",
    function()
      awful.screen.focus_relative(1)
    end,
    {
      description = "focus the next screen",
      group = "screen"
    }),

  awful.key({ modkey }, "bracketleft",
    function()
      awful.screen.focus_relative(-1)
    end,
    {
      description = "focus the previous screen",
      group = "screen"
    }),
})
