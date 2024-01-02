local awful = require("awful")

-- Moves the client to the specified screen in the given direction
---@param direction string The direction to move the client ("left", "right", "up", "down")
local function move_client_to_screen(direction)
	return function(c)
		local screen = awful.screen.focused()

		-- Get the next screen in the specified direction
		local next_screen = screen.get_next_in_direction(screen, direction)

		if next_screen then
			-- If there is a next screen, move the client to that screen
			screen = next_screen
		else
			-- If there is no next screen in the specified direction, find the rightmost screen
			while screen.get_next_in_direction(screen, "right") do
				screen = screen.get_next_in_direction(screen, "right")
			end

			-- Focus the rightmost screen
			awful.screen.focus(screen)
		end

		-- Move the client to the selected screen
		c:move_to_screen(screen)
	end
end

client.connect_signal("request::default_keybindings", function()
	awful.keyboard.append_client_keybindings({

		awful.key({ modkey, "Shift" }, "[", move_client_to_screen("left"), {
			description = "move client to previous/next screen",
			group = "client",
		}),

		awful.key({ modkey, "Shift" }, "]", move_client_to_screen("right"), {
			description = "move client to previous/next screen",
			group = "client",
		}),

		awful.key({ modkey, "Control" }, "f", awful.client.floating.toggle, {
			description = "toggle floating",
			group = "client",
		}),

		awful.key({ modkey }, "f", function(c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end, {
			description = "toggle fullscreen",
			group = "client",
		}),

		awful.key({ modkey }, "q", function(c)
			c:kill()
		end, {
			description = "close",
			group = "client",
		}),

		awful.key({ modkey, "Control" }, "Return", function(c)
			c:swap(awful.client.getmaster())
		end, {
			description = "move to master",
			group = "client",
		}),

		awful.key({ modkey }, "o", function(c)
			c:move_to_screen()
		end, {
			description = "move to screen",
			group = "client",
		}),

		awful.key({ modkey }, "t", function(c)
			c.ontop = not c.ontop
		end, {
			description = "toggle keep on top",
			group = "client",
		}),

		awful.key({ modkey, "Control" }, "n", function(c)
			-- The client currently has the input focus, so it cannot be
			-- minimized, since minimized clients can't have the focus.
			c.minimized = true
		end, {
			description = "minimize",
			group = "client",
		}),

		awful.key({ modkey }, "m", function(c)
			c.maximized = not c.maximized
			c:raise()
		end, {
			description = "(un)maximize",
			group = "client",
		}),

		awful.key({ modkey, "Control" }, "m", function(c)
			c.maximized_vertical = not c.maximized_vertical
			c:raise()
		end, {
			description = "(un)maximize vertically",
			group = "client",
		}),

		awful.key({ modkey, "Shift" }, "m", function(c)
			c.maximized_horizontal = not c.maximized_horizontal
			c:raise()
		end, {
			description = "(un)maximize horizontally",
			group = "client",
		}),

		awful.key({ modkey }, "Tab", function()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		end, { description = "go back", group = "client" }),

		awful.key({ modkey, "Control" }, "t", function(c)
			awful.titlebar.toggle(c, "left")
		end, { description = "toggle titlebar", group = "client" }),
	})
end)

client.connect_signal("request::default_mousebindings", function()
	awful.mouse.append_client_mousebindings({
		awful.button({}, 1, function(c)
			c:activate({
				context = "mouse_click",
			})
		end),
		awful.button({ modkey }, 1, function(c)
			c:activate({
				context = "mouse_click",
				action = "mouse_move",
			})
		end),
		awful.button({ modkey }, 3, function(c)
			c:activate({
				context = "mouse_click",
				action = "mouse_resize",
			})
		end),
	})
end)
