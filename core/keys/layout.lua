local awful = require("awful")
local bling = require("modules.bling")

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
	--          ╭─────────────────────────────────────────────────────────╮
	--          │                          Focus                          │
	--          ╰─────────────────────────────────────────────────────────╯
	awful.key({ modkey }, "j", function()
		awful.client.focus.bydirection("down", client.focus)
		bling.module.flash_focus.flashfocus(client.focus)
	end, { description = "focus down", group = "layout" }),

	awful.key({ modkey }, "k", function()
		awful.client.focus.bydirection("up", client.focus)
		bling.module.flash_focus.flashfocus(client.focus)
	end, { description = "focus up", group = "layout" }),

	awful.key({ modkey }, "l", function()
		awful.client.focus.bydirection("right", client.focus)
		bling.module.flash_focus.flashfocus(client.focus)
	end, {
		description = "focus right",
		group = "layout",
	}),

	awful.key({ modkey }, "h", function()
		awful.client.focus.bydirection("left", client.focus)
		bling.module.flash_focus.flashfocus(client.focus)
	end, {
		description = "focus left",
		group = "layout",
	}),

	--          ╭─────────────────────────────────────────────────────────╮
	--          │                          move                           │
	--          ╰─────────────────────────────────────────────────────────╯

	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.bydirection("down", client.focus)
	end, {
		description = "swap with client below",
		group = "layout",
	}),

	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.bydirection("up", client.focus)
	end, {
		description = "swap with client above",
		group = "layout",
	}),

	awful.key({ modkey, "Shift" }, "l", function()
		awful.client.swap.global_bydirection("right", client.focus)
	end, {
		description = "swap with client to the right",
		group = "layout",
	}),

	awful.key({ modkey, "Shift" }, "h", function()
		awful.client.swap.global_bydirection("left", client.focus)
	end, {
		description = "swap with client to the left",
		group = "layout",
	}),

	awful.key({ modkey }, "u", awful.client.urgent.jumpto, {
		description = "jump to urgent client",
		group = "layout",
	}),

	awful.key({ modkey, "Control" }, "l", function()
		awful.tag.incmwfact(0.05)
	end, {
		description = "increase master width factor",
		group = "layout",
	}),

	awful.key({ modkey, "Control" }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, {
		description = "decrease master width factor",
		group = "layout",
	}),

	-- 	awful.key({ modkey, "Control" }, "h", function()
	-- 		awful.tag.incncol(1, nil, true)
	-- 	end, {
	-- 		description = "increase the number of columns",
	-- 		group = "layout",
	-- 	}),
	--
	-- 	awful.key({ modkey, "Control" }, "l", function()
	-- 		awful.tag.incncol(-1, nil, true)
	-- 	end, {
	-- 		description = "decrease the number of columns",
	-- 		group = "layout",
	-- 	}),
	--
	-- 	awful.key({ modkey }, "space", function()
	-- 		awful.layout.inc(1)
	-- 	end, {
	-- 		description = "select next",
	-- 		group = "layout",
	-- 	}),
	--
	-- 	awful.key({ modkey, "Shift" }, "space", function()
	-- 		awful.layout.inc(-1)
	-- 	end, {
	-- 		description = "select previous",
	-- 		group = "layout",
	-- 	}),
})

awful.keyboard.append_global_keybindings({
	awful.key({
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
		end,
	}),
	awful.key({
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
		end,
	}),
	awful.key({
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
		end,
	}),
	awful.key({
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
		end,
	}),
	awful.key({
		modifiers = { modkey },
		keygroup = "numpad",
		description = "select layout directly",
		group = "layout",
		on_press = function(index)
			local t = awful.screen.focused().selected_tag
			if t then
				t.layout = t.layouts[index] or t.layout
			end
		end,
	}),
})
