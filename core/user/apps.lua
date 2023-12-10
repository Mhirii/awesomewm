local gears      = require("gears")

local terminal   = "alacritty"
local editor     = os.getenv("EDITOR") or "nvim"

local config_dir = gears.filesystem.get_xdg_config_home()
local scripts    = config_dir .. "awesome/scripts/"

local user_apps  = {
  terminal = terminal,
  editor = editor,
  editor_cmd = terminal .. " -e " .. editor,
  browser = os.getenv("BROWSER") or "firedragon",
  visual = os.getenv("VISUAL") or "code",
  files = os.getenv("FILEBROWSER") or "ranger",
  colorpicker = scripts .. "colorpicker.sh"
}

return user_apps
