-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--

local programs = require("modules.programs")


hl.on("hyprland.start", function ()
    hl.exec_cmd(programs.wallpaper_utility)
    hl.exec_cmd(programs.status_bar)
    hl.exec_cmd(programs.terminal)
end)

