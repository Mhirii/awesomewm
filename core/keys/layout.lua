local awful = require("awful")

-- Layout related keybindings
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

  awful.key({ modkey, "Shift" }, "j", function()
    awful.client.swap.byidx(1)
  end, {
    description = "swap with next client by index",
    group = "client"
  }),

  awful.key({ modkey, "Shift" }, "k", function()
      awful.client.swap.byidx(-1)
    end,
    {
      description = "swap with previous client by index",
      group = "client"
    }),

  awful.key({ modkey }, "u", awful.client.urgent.jumpto, {
    description = "jump to urgent client",
    group = "client"
  }),

  awful.key({ modkey }, "l", function()
      awful.tag.incmwfact(0.05)
    end,
    {
      description = "increase master width factor",
      group = "layout"
    }),

  awful.key({ modkey }, "h", function()
      awful.tag.incmwfact(-0.05)
    end,
    {
      description = "decrease master width factor",
      group = "layout"
    }),

  awful.key({ modkey, "Shift" }, "h", function()
      awful.tag.incnmaster(1, nil, true)
    end,
    {
      description = "increase the number of master clients",
      group = "layout"
    }),

  awful.key({ modkey, "Shift" }, "l", function()
      awful.tag.incnmaster(-1, nil, true)
    end,
    {
      description = "decrease the number of master clients",
      group = "layout"
    }),

  awful.key({ modkey, "Control" }, "h", function()
      awful.tag.incncol(1, nil, true)
    end,
    {
      description = "increase the number of columns",
      group = "layout"
    }),

  awful.key({ modkey, "Control" }, "l", function()
      awful.tag.incncol(-1, nil, true)
    end,
    {
      description = "decrease the number of columns",
      group = "layout"
    }),

  awful.key({ modkey }, "space", function()
      awful.layout.inc(1)
    end,
    {
      description = "select next",
      group = "layout"
    }),

  awful.key({ modkey, "Shift" }, "space", function()
      awful.layout.inc(-1)
    end,
    {
      description = "select previous",
      group = "layout"
    })
})

awful.keyboard.append_global_keybindings({ awful.key {
  modifiers = { modkey },
  keygroup = "numrow",
  description = "only view tag",
  group = "tag",
  on_press = function(index)
    local screen = awful.screen.focused()
    local tag = screen.tags[index]
    if tag then
      tag:view_only()
    end
  end
}, awful.key {
  modifiers = { modkey, "Control" },
  keygroup = "numrow",
  description = "toggle tag",
  group = "tag",
  on_press = function(index)
    local screen = awful.screen.focused()
    local tag = screen.tags[index]
    if tag then
      awful.tag.viewtoggle(tag)
    end
  end
}, awful.key {
  modifiers = { modkey, "Shift" },
  keygroup = "numrow",
  description = "move focused client to tag",
  group = "tag",
  on_press = function(index)
    if client.focus then
      local tag = client.focus.screen.tags[index]
      if tag then
        client.focus:move_to_tag(tag)
      end
    end
  end
}, awful.key {
  modifiers = { modkey, "Control", "Shift" },
  keygroup = "numrow",
  description = "toggle focused client on tag",
  group = "tag",
  on_press = function(index)
    if client.focus then
      local tag = client.focus.screen.tags[index]
      if tag then
        client.focus:toggle_tag(tag)
      end
    end
  end
}, awful.key {
  modifiers = { modkey },
  keygroup = "numpad",
  description = "select layout directly",
  group = "layout",
  on_press = function(index)
    local t = awful.screen.focused().selected_tag
    if t then
      t.layout = t.layouts[index] or t.layout
    end
  end
} })
