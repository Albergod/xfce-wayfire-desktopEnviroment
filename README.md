# XFCE + Wayfire Desktop Environment

Entorno de escritorio XFCE con Wayfire como compositor Wayland.
Compatible con cualquier distro basada en Arch (Arch Linux, Manjaro, EndeavourOS, etc.)

## Contenido

- `config/` — Configuraciones de `~/.config/` (wayfire, xfce4, waybar, ghostty, etc.)
- `local-bin/` — Scripts de `~/.local/bin/`
- `themes/` — Temas GTK
- `icons/` — Cursores e iconos
- `lists/pkglist.txt` — Paquetes oficiales (repos Arch)
- `lists/aurlist.txt` — Paquetes AUR

## Instalación

En una instalación limpia de Arch o derivadas:

```bash
# Si no tienes yay:
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd ..

# Instalar el entorno:
git clone https://github.com/Albergod/xfce-wayfire-desktopEnviroment.git
cd xfce-wayfire-desktopEnviroment
chmod +x restore.sh
./restore.sh
```

## Actualizar backup

```bash
./update.sh
```

## Notas

- Las **fuentes** no están incluidas por tamaño. Respaldar aparte en `~/.fonts/`
- El script hace backup de configs existentes (agrega `.bak`)
- Después de restaurar, **reiniciar la sesión**
