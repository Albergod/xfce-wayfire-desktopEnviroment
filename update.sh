#!/bin/bash
# Actualizar el repo dotfiles con la configuración actual del sistema
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Actualizando dotfiles ==="

# Configs
echo "Copiando configs..."
for item in wayfire.ini xfce4 environment.d autostart gtk-3.0 gtk-4.0 waybar ghostty Thunar hypr fontconfig mimeapps.list xdg-desktop-portal; do
    if [ -e "$HOME/.config/$item" ]; then
        rm -rf "$DOTFILES_DIR/config/$item"
        cp -r "$HOME/.config/$item" "$DOTFILES_DIR/config/$item"
        echo "  ✓ $item"
    fi
done

# Systemd
mkdir -p "$DOTFILES_DIR/config/systemd/user"
cp ~/.config/systemd/user/*.service "$DOTFILES_DIR/config/systemd/user/" 2>/dev/null
echo "  ✓ systemd services"

# Scripts
cp ~/.local/bin/*.sh "$DOTFILES_DIR/local-bin/" 2>/dev/null
echo "  ✓ scripts"

# Temas e iconos
rm -rf "$DOTFILES_DIR/themes" "$DOTFILES_DIR/icons"
cp -r ~/.themes "$DOTFILES_DIR/themes" 2>/dev/null
cp -r ~/.icons "$DOTFILES_DIR/icons" 2>/dev/null
echo "  ✓ temas e iconos"

# Listas de paquetes
pacman -Qqe > "$DOTFILES_DIR/lists/pkglist.txt"
pacman -Qqm > "$DOTFILES_DIR/lists/aurlist.txt"
echo "  ✓ listas de paquetes"

echo ""
echo "✅ Dotfiles actualizados. Haz commit y push:"
echo "   cd $DOTFILES_DIR && git add -A && git commit -m 'update' && git push"
