local gears       = require("gears")
local menubar     = require("menubar")
local userapps    = require("core.user.apps")
local awful       = require("awful")

local terminal    = userapps.terminal
local browser     = userapps.browser
local editor      = userapps.editor
local editor_cmd  = userapps.editor_cmd
local visual      = userapps.visual
local files       = userapps.files
local colorpicker = userapps.colorpicker



-- local function run_script(script)
--   awful.util.spawn("sh" .. scripts .. script)
-- end

awful.keyboard.append_global_keybindings({
  awful.key({ modkey }, "Return",
    function()
      awful.spawn(terminal)
    end,
    {
      description = "open a terminal",
      group = "launcher"
    }),

  awful.key({ modkey }, "b",
    function()
      awful.spawn(browser)
    end,
    {
      description = "open default browser",
      group = "launcher"
    }),

  awful.key({ modkey }, "e",
    function()
      awful.spawn(terminal .. " -e " .. files)
    end,
    {
      description = "open " .. files,
      group = "launcher"
    }),

  awful.key({ modkey, "Shift" }, "e",
    function()
      awful.spawn("thunar")
    end,
    {
      description = "open thunar ",
      group = "launcher"
    }),

  awful.key({ modkey }, "v",
    function()
      awful.spawn("copyq menu")
    end,
    {
      description = "open clipboard ",
      group = "launcher"
    }),

  awful.key({ modkey, "Shift" }, "d",
    function()
      awful.spawn("discord")
    end,
    {
      description = "open discord",
      group = "launcher"
    }),

  awful.key({ modkey, "Shift" }, "t",
    function()
      awful.spawn("telegram-desktop")
    end,
    {
      description = "open telegram",
      group = "launcher"
    }),

  awful.key({ modkey }, "n",
    function()
      awful.spawn(editor_cmd)
    end,
    {
      description = "open nvim",
      group = "launcher"
    }),

  awful.key({ modkey, "Shift" }, "n",
    function()
      awful.spawn("neovide")
    end,
    {
      description = "open neovide",
      group = "launcher"
    }),

  awful.key({ modkey }, "c",
    function()
      awful.spawn(visual)
    end,
    {
      description = "open Visual Editor",
      group = "launcher"
    }),


  awful.key({ modkey }, "r",
    function()
      awful.screen.focused().promptbox:run()
    end,
    {
      description = "run prompt",
      group = "launcher"
    }),

  awful.key({ modkey }, "p",
    function()
      menubar.show()
    end,
    {
      description = "show the menubar",
      group = "launcher"
    }),

  awful.key({ modkey, "Shift" }, "p",
    function()
      awful.spawn(colorpicker)
    end,
    {
      description = "open color picker",
      group = "launcher"
    }
  )
})
