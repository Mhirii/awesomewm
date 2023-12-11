local sysctrl = require("helpers.system_control")
local make    = require("helpers.make")


local function get_next_screen(direction)
  local previous_direction = direction == "right" and "left" or "right"
  local screen = awful.screen.focused()
  if (screen.get_next_in_direction(screen, direction)) then
    return screen.get_next_in_direction(screen, direction)
  end

  while screen.get_next_in_direction(screen, previous_direction) ~= nil do
    screen = screen.get_next_in_direction(screen, previous_direction)
  end

  return screen
end

local helpers = {
  system_control = sysctrl,
  make = make,
  get_next_screen = get_next_screen
}
return helpers
