-----------------------
----- PROGRAMS --------
-----------------------

local scripts_path = "$HOME/.config/hypr/scripts/"


local M = {
    terminal = "kitty",
    menu              = "rofi -show drun -display-drun '' -show-icons",
    status_bar        = "waybar",
    wallpaper_utility = "hyprpaper",
    vol_up            = scripts_path .. "volume_up.sh",
    vol_down          = scripts_path .. "volume_down.sh",
    toggle_volume     = scripts_path .. "toggle_volume.sh",
    toggle_mic        = scripts_path .. "toggle_mic.sh",
    br_up             = scripts_path .. "brightness_up.sh",
    br_down           = scripts_path .. "brightness_down.sh",
}

return M
