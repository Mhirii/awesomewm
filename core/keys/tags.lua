local awful = require("awful")

awful.keyboard.append_global_keybindings({
  awful.key({ modkey }, "Left",
    awful.tag.viewprev,
    {
      description = "view previous",
      group = "tag"
    }),

  awful.key({ modkey }, "Right",
    awful.tag.viewnext,
    {
      description = "view next",
      group = "tag"
    }),

  awful.key({ modkey }, "Tab",
    awful.tag.history.restore,
    {
      description = "go back",
      group = "tag"
    }),

  awful.key({ modkey }, "u",
    function()
      awful.client.urgent.jumpto()
    end,
    {
      description = "jump to urgent client",
      group = "tag"
    }
  )
})
