-- ##################################################
-- ################## VARIABLES #####################
-- ##################################################

local mainMod      = "SUPER"
local terminal     = "ptyxis"
local fileManager  = "nautilus"
local menu         = "ags toggle rightmenu"

-- ##################################################
-- ################# APLICACIONES ###################
-- ##################################################

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind("CTRL + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind("ALT + F4", hl.dsp.window.close())

-- Alternar ventana flotante
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
-- Minimizar ventana actual (mover a workspace especial "minimized" sin cambiar el foco general)
hl.bind(mainMod .. " + M", hl.dsp.window.move({ workspace = "special:minimized", follow = false }))
-- Restaurar (mostrar/ocultar) las ventanas minimizadas
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.workspace.toggle_special("minimized"))

hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())

-- ##################################################
-- ################# SNAP WINDOWS ###################
-- ##################################################

-- Mitad izquierda (Snap Left)
hl.bind(mainMod .. " + left", function()
    hl.dispatch(hl.dsp.window.move({ direction = "l" }))
    hl.dispatch(hl.dsp.window.resize({ x = "50%", y = "100%" }))
    hl.dispatch(hl.dsp.window.move({ x = 0, y = 0 }))
end)

-- Mitad derecha (Snap Right)
hl.bind(mainMod .. " + right", function()
    hl.dispatch(hl.dsp.window.move({ direction = "r" }))
    hl.dispatch(hl.dsp.window.resize({ x = "50%", y = "100%" }))
    hl.dispatch(hl.dsp.window.move({ x = "50%", y = 0 }))
end)

-- Maximizar (Snap Up)
hl.bind(mainMod .. " + up", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

-- Restaurar / Centrar (Snap Down)
hl.bind(mainMod .. " + down", function()
    hl.dispatch(hl.dsp.window.fullscreen({ mode = "fullscreen", action = "unset" }))
    hl.dispatch(hl.dsp.window.resize({ x = 900, y = 600 }))
    hl.dispatch(hl.dsp.window.center())
end)

-- ##################################################
-- ################# SYSTEM KEYS ####################
-- ##################################################

-- Mostrar Escritorio (Win + D) - Usando un workspace especial como "escritorio"
hl.bind(mainMod .. " + D", hl.dsp.workspace.toggle_special("desktop"))

-- Bloquear Pantalla (Win + L)
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock || swaylock || lumina-screenlocker"))

-- ##################################################
-- ################# ALT + TAB ######################
-- ##################################################

hl.bind("ALT + TAB", hl.dsp.window.cycle_next())
hl.bind("ALT + SHIFT + TAB", hl.dsp.window.cycle_next({ next = false }))
hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }))

-- ##################################################
-- ################ SCREENSHOT ######################
-- ##################################################

hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))
hl.bind("Print", hl.dsp.exec_cmd("grim ~/Imágenes/screenshot_$(date +%s).png"))

-- ##################################################
-- ################ WORKSPACES ######################
-- ##################################################

for i = 1, 5 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- ##################################################
-- ################ MOUSE ###########################
-- ##################################################

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ##################################################
-- ################ MULTIMEDIA ######################
-- ##################################################

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
