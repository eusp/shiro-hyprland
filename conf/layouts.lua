local colors = require("conf/colors")

hl.config({
    general = {
        layout = "dwindle",
        border_size = 2,
        gaps_in = 5,
        gaps_out = 10,

        col = {
            active_border = colors.primaryMuted,
            inactive_border = colors.overlay0,
        },

        -- Permitir cambiar el tamaño arrastrando los bordes
        resize_on_border = true,
        extend_border_grab_area = 15,
        hover_icon_on_border = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },
})

-- Smart gaps (no gaps when only one window or fullscreen)
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
