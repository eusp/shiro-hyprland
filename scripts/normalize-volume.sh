#!/usr/bin/env bash
# normalize-volume.sh — deja el volumen de salida en un porcentaje fijo:
#   · una vez al arrancar (todos los sinks que ya existan)
#   · cada vez que aparece un sink NUEVO (conectar audífonos BT, un DAC USB,
#     HDMI, etc.)
#
# Motivo: los audífonos M100 (y otros BT) fuerzan el volumen al máximo al
# conectarse. Ver /mnt/Disco02/Projects/bluetooth-error/volumen-40.md
#
# Uso:  normalize-volume.sh [porcentaje]     (por defecto 25)

set -uo pipefail

# pactl traduce su salida al idioma del sistema ("Evento 'nuevo' en destino #7").
# Forzamos C para poder parsear en inglés de forma estable.
export LC_ALL=C

TARGET="${1:-25}"

norm() {
    local sink="$1"
    [ -n "$sink" ] || return 0
    pactl set-sink-mute   "$sink" 0            >/dev/null 2>&1 || true
    pactl set-sink-volume "$sink" "${TARGET}%" >/dev/null 2>&1 || true
    local name
    name=$(pactl list short sinks 2>/dev/null | awk -v i="$sink" '$1==i || $2==i {print $2}')
    echo "normalize-volume: sink ${name:-$sink} -> ${TARGET}%"
}

# Esperar a que PipeWire responda (arranque de sesión).
for _ in $(seq 1 60); do
    pactl info >/dev/null 2>&1 && break
    sleep 1
done

# Al arrancar: normalizar lo que ya haya.
sleep 2
while read -r idx _; do
    norm "$idx"
done < <(pactl list short sinks 2>/dev/null)

# Reaccionar a sinks nuevos.
#   Línea típica de pactl subscribe:  Event 'new' on sink #52
pactl subscribe 2>/dev/null | while read -r _ event target extra; do
    [ "$event" = "'new'" ]                     || continue
    [ "$target" = "on" ]                       || continue
    [ "${extra%% *}" = "sink" ]                || continue
    id="${extra##*#}"
    sleep 1          # dejar que el sink termine de configurarse
    norm "$id"
done
