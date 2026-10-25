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

-- Zona útil del monitor activo: sin lo que reserva la barra de AGS y con un
-- margen igual a gaps_out. Desde Hyprland 0.56 resize/move solo aceptan
-- píxeles (ya no "50%"), así que las mitades se calculan aquí.
local SNAP_GAP = 10

local function work_area()
    local m = hl.get_active_monitor()
    local r = m.reserved
    local x = m.x + r.left + SNAP_GAP
    local y = m.y + r.top + SNAP_GAP
    local w = math.floor(m.width / m.scale) - r.left - r.right - 2 * SNAP_GAP
    local h = math.floor(m.height / m.scale) - r.top - r.bottom - 2 * SNAP_GAP
    return x, y, w, h
end

-- Deja la ventana flotante en ese rectángulo. Maximizada o en pantalla
-- completa Hyprland no la deja mover ni cambiar de tamaño ("Window is fullscreen").
local function place(x, y, w, h)
    hl.dispatch(hl.dsp.window.fullscreen({ mode = "maximized", action = "unset" }))
    hl.dispatch(hl.dsp.window.fullscreen({ mode = "fullscreen", action = "unset" }))
    hl.dispatch(hl.dsp.window.float({ action = "enable" }))
    hl.dispatch(hl.dsp.window.resize({ x = w, y = h }))
    hl.dispatch(hl.dsp.window.move({ x = x, y = y }))
end

local function snap_left()
    local x, y, w, h = work_area()
    place(x, y, math.floor((w - SNAP_GAP) / 2), h)
end

local function snap_right()
    local x, y, w, h = work_area()
    local half = math.floor((w - SNAP_GAP) / 2)
    place(x + w - half, y, half, h)
end

-- Quita el maximizado o la pantalla completa; si la ventana estaba acomodada
-- a un lado (flotante), la devuelve al mosaico
local function restore()
    local w = hl.get_active_window()
    if not w then return end
    if w.fullscreen ~= 0 then
        hl.dispatch(hl.dsp.window.fullscreen({ mode = "maximized", action = "unset" }))
        hl.dispatch(hl.dsp.window.fullscreen({ mode = "fullscreen", action = "unset" }))
    elseif w.floating then
        hl.dispatch(hl.dsp.window.float({ action = "unset" }))
    end
end

-- Mitad izquierda (Snap Left)
hl.bind(mainMod .. " + left", snap_left)

-- Mitad derecha (Snap Right)
hl.bind(mainMod .. " + right", snap_right)

-- Maximizar (Snap Up)
hl.bind(mainMod .. " + up", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

-- Pantalla completa
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Desmaximizar (Snap Down)
hl.bind(mainMod .. " + down", restore)

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
