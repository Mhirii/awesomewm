local gears = require("gears")
local config_dir = gears.filesystem.get_xdg_config_home()
local scripts = config_dir .. "awesome/scripts/"

-- local terminal = "alacritty --config-file " .. config_dir .. "awesome/conf/alacritty.toml"
local terminal = "wezterm"
local editor = os.getenv("EDITOR") or "nvim"
local editor_cmd = terminal .. " -e " .. editor
local browser = os.getenv("BROWSER") or "firefox"
local dev_browser = os.getenv("DEV_BROWSER") or "firefox-developer-edition"
local visual = "code --password-store='gnome'"
local files = os.getenv("FILEBROWSER") or "ranger"
local colorpicker = scripts .. "colorpicker.sh"

local apps = {
	terminal = terminal,
	editor = editor,
	editor_cmd = editor_cmd,
	browser = browser,
	dev_browser = dev_browser,
	visual = visual,
	files = files,
	colorpicker = colorpicker,
}

local user = {
	apps = apps,
}

return user
