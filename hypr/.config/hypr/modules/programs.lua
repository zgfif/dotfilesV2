-----------------------
----- PROGRAMS --------
-----------------------

local scripts_dir = os.getenv("HOME") .. "/.config/hypr/scripts/"



local M = {
    terminal = "kitty",
    menu              = "rofi -show drun -display-drun '' -show-icons",
    status_bar        = "waybar",
    wallpaper_utility = "hyprpaper",
    vol_up            = scripts_dir .. "volume_up.sh",
    vol_down          = scripts_dir .. "volume_down.sh",
    toggle_volume     = scripts_dir .. "toggle_volume.sh",
    toggle_mic        = scripts_dir .. "toggle_mic.sh",
    br_up             = scripts_dir .. "brightness_up.sh",
    br_down           = scripts_dir .. "brightness_down.sh",
}

return M
