-- This is used later as the default terminal and editor to run.

local terminal = "alacritty"
local editor = os.getenv("EDITOR") or "nvim"

local user_apps = {
  terminal = terminal,
  editor = editor,
  editor_cmd = terminal .. " -e " .. editor,
  browser = os.getenv("BROWSER") or "firedragon",
  visual = os.getenv("VISUAL") or "code"
}

return user_apps
