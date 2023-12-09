local awful = require("awful")

awful.keyboard.append_global_keybindings({
  awful.key({ modkey }, "j",
    function()
      awful.client.focus.byidx(1)
    end,
    { description = "focus next by index", group = "client" }),

  awful.key({ modkey }, "k",
    function()
      awful.client.focus.byidx(-1)
    end,
    { description = "focus previous by index", group = "client" }),

  awful.key({ modkey }, "Tab",
    function()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end,
    { description = "go back", group = "client" }),

  awful.key({ modkey }, "bracketright",
    function()
      awful.screen.focus_relative(1)
    end,
    { description = "focus the next screen", group = "screen" }),

  awful.key({ modkey }, "bracketleft",
    function()
      awful.screen.focus_relative(-1)
    end,
    { description = "focus the previous screen", group = "screen" }),

  awful.key({ modkey, "Control" }, "n",
    function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        c:activate {
          raise = true,
          context = "key.unminimize"
        }
      end
    end,
    { description = "restore minimized", group = "client" })
})
