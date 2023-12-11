local spawn = require("awful.spawn")
local gears_string = require("gears.string")


local syscontrol = {}
-- ───────────────────────────── Volume control ───────────────────────────── --

--[[
  Retrieves the current volume level and mute status using the `pamixer` command.

  Example Usage:
    syscontrol.get_volume()

  Inputs:
    None

  Outputs:
    None. The function emits a signal with the volume level and mute status.
  ]]
function syscontrol.get_volume()
  spawn.easy_async(
    "pamixer --get-mute --get-volume", function(stdout)
      local muted, volume = table.unpack(gears_string.split(stdout, " "))
      awesome.emit_signal("signal::volume", tonumber(volume), muted == "true")
    end
  )
end

--[[ Controls the volume level.

  Args:

    type (string): The action to be performed. Possible values are "increase", "decrease", "mute", or any other value to set the volume directly.

    value (number): The amount by which the volume should be changed. This parameter is only used when `type` is "increase" or "decrease".

  Example Usage:

    syscontrol.volume_control("increase", 10)
    `This code will increase the volume by 10 units.`
  ]]
---@param type string
---@param value number
---@return nil
function syscontrol.volume_control(type, value)
  local cmd
  if type == "increase" then
    cmd = "pamixer -i " .. tostring(value)
  elseif type == "decrease" then
    cmd = "pamixer -d " .. tostring(value)
  elseif type == "mute" then
    cmd = "pamixer -t"
  else
    cmd = "pamixer --set-volume " .. tostring(value)
  end

  spawn.easy_async(cmd, syscontrol.get_volume)
end

-- ─────────────────────────── Brightness control ─────────────────────────── --

--[[ Returns the current brightness level.

  Example Usage:

    syscontrol.get_brightness()
    `This code will return the current brightness level.`
  ]]
---@return nil
function syscontrol.get_brightness()
  spawn.easy_async_with_shell(
    "brightnessctl i | grep -o '[0-9]*%'", function(stdout)
      local value = tonumber(stdout:match("(%d+)"))
      awesome.emit_signal("brightness::value", value)
    end
  )
end

--[[ Controls the screen brightness level.

 Args:

   type (string): The action to be performed. Possible values are "increase" or "decrease" to adjust brightness by 5%, or any other value to set the brightness directly.

   value (number): The brightness percentage to set when `type` is not "increase" or "decrease".

 Example Usage:

   syscontrol.brightness_control("increase")
   `This code will increase the brightness by 5%.`

   syscontrol.brightness_control("decrease")
   `This code will decrease the brightness by 5%.`

   syscontrol.brightness_control("set", 50)
   `This code will set the brightness to 50%.`
]]
---@param type string
---@param value number
---@return nil
function syscontrol.brightness_control(type, value)
  local cmd
  if type == "increase" then
    cmd = "brightnessctl set 5%+ -q"
  elseif type == "decrease" then
    cmd = "brightnessctl set 5%- -q"
  else
    cmd = "brightnessctl set -q " .. tostring(value) .. "%"
  end

  spawn.easy_async(cmd, syscontrol.get_brightness)
end

-- ─────────────────────────────── Mic toggle ─────────────────────────────── --
function syscontrol.get_mic_mute()
  spawn.easy_async(
    "pamixer --default-source --get-mute", function(stdout)
      awesome.emit_signal("microphone::mute", stdout:match("true"))
    end
  )
end

function syscontrol.mic_toggle(type, value)
  spawn.easy_async("pactl set-source-mute @DEFAULT_SOURCE@ toggle", syscontrol.get_mic_mute)
end

return syscontrol
