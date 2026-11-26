hl.config({
    decoration = {
        rounding = 5,

        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(00000099)",
        },

        blur = {
            enabled = true,
            passes = 3,
            new_optimizations = true,
            ignore_opacity = true,
            xray = true,
        },
    },
})

-- Sin la frase aleatoria ("splash") que Hyprland dibuja sobre el fondo
hl.config({
    misc = {
        disable_splash_rendering = true,
    },
})
