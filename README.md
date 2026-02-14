# Dotfiles - Entorno XFCE/Wayfire

Configuración personal del entorno de escritorio XFCE con Wayfire como compositor Wayland.

## Contenido

- `config/` — Archivos de `~/.config/` (wayfire, xfce4, waybar, ghostty, hyprland, etc.)
- `local-bin/` — Scripts de `~/.local/bin/`
- `themes/` — Temas GTK personalizados
- `icons/` — Cursores e iconos personalizados
- `lists/pkglist.txt` — Paquetes oficiales instalados
- `lists/aurlist.txt` — Paquetes AUR instalados

## Restaurar en un Manjaro limpio

```bash
git clone https://github.com/trevaldev/dotfiles.git
cd dotfiles
chmod +x restore.sh
./restore.sh
```

## Notas

- Las **fuentes** no están incluidas por su tamaño (~340MB). Respaldarlas aparte en `~/.fonts/`
- El script hace backup de configs existentes antes de sobreescribir (agrega `.bak`)
- Después de restaurar, **reiniciar la sesión**

## Actualizar el backup

Para actualizar este repo con los cambios actuales:

```bash
./update.sh
```
