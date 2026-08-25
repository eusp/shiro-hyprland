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
    hl.exec_cmd("/usr/libexec/lxqt-policykit-agent")
    hl.exec_cmd("ags run ~/.config/ags/app.ts")
    hl.exec_cmd("bash ~/.config/hypr/scripts/change-wallpaper.sh")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)
