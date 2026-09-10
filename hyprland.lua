-- Migrado de hyprlang (.conf) a Lua: soporte para .conf eliminado en Hyprland 0.57
-- https://wiki.hypr.land/Configuring/Start/

require("conf/monitors")
require("conf/layouts")
require("conf/decorations")
require("conf/animations")
require("conf/input")
require("conf/bindings")
require("conf/rules")

hl.on("hyprland.start", function()
    hl.exec_cmd("bash ~/.config/hypr/scripts/polkit-agent.sh")
    -- Pequeño delay: "hyprland.start" dispara antes de que el compositor
    -- termine de inicializarse del todo, y AGS puede morir en el arranque
    -- si intenta crear su superficie layer-shell demasiado temprano.
    hl.exec_cmd("sh -c 'sleep 1 && ags run ~/.config/ags/app.ts'")
    hl.exec_cmd("bash ~/.config/hypr/scripts/change-wallpaper.sh")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)
