local awful = require("awful")
local playerctl = require("signals.playerctl")
-- local system_control = require("helpers.system_control")
local helpers = require("helpers")
local system_control = helpers.system_control

awful.keyboard.append_global_keybindings({
	awful.key({}, "XF86AudioRaiseVolume", function()
		system_control.volume_control("increase", 5)
	end, {
		description = "increase volume",
		group = "fn keys",
	}),
	awful.key({ "Shift", "Mod1" }, "F3", function()
		system_control.volume_control("increase", 5)
	end, {
		description = "increase volume",
		group = "fn keys",
	}),
	awful.key({}, "XF86AudioLowerVolume", function()
		system_control.volume_control("decrease", 5)
	end, {
		description = "decrease volume",
		group = "fn keys",
	}),
	awful.key({ "Shift", "Mod1" }, "F2", function()
		system_control.volume_control("decrease", 5)
	end, {
		description = "decrease volume",
		group = "fn keys",
	}),
	awful.key({}, "XF86AudioMute", function()
		system_control.volume_control("mute", 0)
	end, {
		description = "mute volume",
		group = "fn keys",
	}),
	awful.key({ "Shift", "Mod1" }, "F1", function()
		system_control.volume_control("mute", 0)
	end, {
		description = "mute volume",
		group = "fn keys",
	}),
	awful.key({}, "XF86AudioPlay", function()
		playerctl:play_pause()
	end, {
		description = "toggle music",
		group = "fn keys",
	}),
	awful.key({ "Shift", "Mod1" }, "F11", function()
		playerctl:play_pause()
	end, {
		description = "toggle music",
		group = "fn keys",
	}),
	awful.key({}, "XF86AudioPrev", function()
		playerctl:previous()
	end, {
		description = "previous music",
		group = "fn keys",
	}),
	awful.key({ "Shift", "Mod1" }, "F10", function()
		playerctl:previous()
	end, {
		description = "previous music",
		group = "fn keys",
	}),
	awful.key({}, "XF86AudioNext", function()
		playerctl:next()
	end, {
		description = "next music",
		group = "fn keys",
	}),
	awful.key({ "Shift", "Mod1" }, "F12", function()
		playerctl:next()
	end, {
		description = "next music",
		group = "fn keys",
	}),
})
