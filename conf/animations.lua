hl.config({
    animations = {
        enabled = true,
    },
})

-- Curvas suaves
hl.curve("smooth",   { type = "bezier", points = { {0.25, 1},   {0.5, 1} } })
hl.curve("overshot", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.1} } })
hl.curve("bounce",   { type = "bezier", points = { {0.3, 1.4},  {0.4, 1} } })

-- Ventanas
hl.animation({ leaf = "windows",     enabled = true, speed = 6,  bezier = "overshot", style = "slide" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 5,  bezier = "smooth",   style = "popin 80%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5,  bezier = "smooth" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 6,  bezier = "smooth" })

-- Workspaces
hl.animation({ leaf = "workspaces", enabled = true, speed = 7, bezier = "overshot", style = "slide" })
