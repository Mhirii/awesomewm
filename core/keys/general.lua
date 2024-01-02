local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local userapps = require("user_settings").apps

awful.keyboard.append_global_keybindings({
	awful.key({ modkey, "Shift" }, "slash", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),

	awful.key({ modkey }, "w", function()
		mymainmenu:show()
	end, { description = "show main menu", group = "awesome" }),

	awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),

	awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

	awful.key({ modkey }, "x", function()
		awful.prompt.run({
			prompt = "Run Lua code: ",
			textbox = awful.screen.focused().mypromptbox.widget,
			exe_callback = awful.util.eval,
			history_path = awful.util.get_cache_dir() .. "/history_eval",
		})
	end, {
		description = "lua execute prompt",
		group = "awesome",
	}),

	--Toggle powermenu
	awful.key({
		modifiers = { modkey, "Shift" },
		key = "c",
		description = "Powermenu",
		group = "awesome",
		on_press = function()
			powermenu.visible = not powermenu.visible
		end,
	}),

	--Lock Screen
	awful.key({
		modifiers = { modkey, "Shift" },
		key = "s",
		description = "Lockscreen",
		group = "awesome",
		on_press = function()
			awesome.emit_signal("screen::lock")
		end,
	}),

	awful.key({ modkey, "Control" }, "y", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:activate({
				raise = true,
				context = "key.unminimize",
			})
		end
	end, { description = "restore minimized", group = "client" }),
})
