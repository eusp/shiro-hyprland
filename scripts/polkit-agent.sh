#!/usr/bin/env bash
# Lanza el primer agente polkit disponible. La ruta cambia según la distro:
# Fedora/Nobara lo instala en /usr/libexec, Arch/CachyOS en /usr/bin.
for agent in \
    /usr/libexec/lxqt-policykit-agent \
    /usr/bin/lxqt-policykit-agent \
    /usr/lib/hyprpolkitagent/hyprpolkitagent \
    /usr/libexec/hyprpolkitagent; do
    [ -x "$agent" ] && exec "$agent"
done
echo "polkit-agent.sh: no se encontró ningún agente polkit" >&2
exit 1
