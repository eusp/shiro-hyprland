# shiro-hyprland

Configuración de Hyprland (en Lua) del escritorio Shiro. Forma parte de
[shiro-theme](https://github.com/eusp/shiro-theme), que la instala y le genera los colores.

Proyectos Shiro: [shiro-theme](https://github.com/eusp/shiro-theme) ·
[shiro-ags](https://github.com/eusp/shiro-ags) ·
**shiro-hyprland** ·
[shiro-sddm](https://github.com/eusp/shiro-sddm) ·
[shiro-grub](https://github.com/eusp/shiro-grub) ·
[shiro-limine](https://github.com/eusp/shiro-limine)

## Instalación

Lo normal es instalar todo desde shiro-theme:

```bash
git clone https://github.com/eusp/shiro-theme.git ~/.config/shiro-theme
bash ~/.config/shiro-theme/install.sh
```

A mano: el repo vive en `~/.config/shiro-hyprland` y `~/.config/hypr` es un symlink hacia él
(Hyprland solo lee `~/.config/hypr`).

```bash
git clone https://github.com/eusp/shiro-hyprland.git ~/.config/shiro-hyprland
ln -s ~/.config/shiro-hyprland ~/.config/hypr
```

Requiere Hyprland 0.55+ (configuración en Lua; el formato `.conf` ya no está soportado).

## Estructura

```
hyprland.lua              Punto de entrada: carga conf/ y autoarranque (AGS, fondo, cliphist, polkit)
conf/
  colors.lua              Paleta y rutas del fondo — AUTO GENERADO por shiro-theme, no editar
  monitors.lua            Monitores (revisar el nombre de salida con `hyprctl monitors`)
  bindings.lua            Atajos de teclado
  input.lua               Teclado (us,es), mouse
  layouts.lua, decorations.lua, animations.lua, rules.lua
scripts/
  change-wallpaper.sh     Fondo animado (mpvpaper) o estático (hyprpaper) según shiro-theme/wallpaper-mode
  normalize-volume.sh     Deja el volumen en 25% al iniciar y al conectar audífonos
  polkit-agent.sh         Lanza el agente polkit que exista (ruta distinta en Fedora y Arch)
systemd/
  normalize-volume.service  Servicio de usuario para normalize-volume.sh
wallpapers/               Copia del fondo del tema activo (la hace shiro-theme)
```

## Dependencias

`hyprland`, `hyprpaper`, `mpvpaper`, `hyprlock`, `lxqt-policykit`, `wl-clipboard`, `cliphist`,
`grim`, `slurp`, `brightnessctl`, `wireplumber`, `ptyxis`, `nautilus`.
En Arch/CachyOS las instala `install.sh deps` de shiro-theme.
