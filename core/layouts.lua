local awful = require("awful")
require("awful.autofocus")
require("awful.hotkeys_popup.keys")

tag.connect_signal("request::default_layouts", function()
	awful.layout.append_default_layouts({
		awful.layout.suit.tile,
		awful.layout.suit.max,
		awful.layout.suit.magnifier,
	})
end)
