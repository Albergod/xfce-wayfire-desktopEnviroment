#!/bin/bash
# Script de restauración del entorno XFCE/Wayfire de trevaldev
# Uso: ./restore.sh

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Restauración del entorno XFCE/Wayfire ==="
echo ""

# Paso 1: Instalar paquetes oficiales
echo "[1/6] Instalando paquetes oficiales..."
sudo pacman -S --needed - < "$DOTFILES_DIR/lists/pkglist.txt"

# Paso 2: Instalar paquetes AUR (usando yay o paru)
echo "[2/6] Instalando paquetes AUR..."
if command -v yay &>/dev/null; then
    yay -S --needed - < "$DOTFILES_DIR/lists/aurlist.txt"
elif command -v paru &>/dev/null; then
    paru -S --needed - < "$DOTFILES_DIR/lists/aurlist.txt"
else
    echo "⚠ No se encontró yay ni paru. Instala los paquetes AUR manualmente:"
    cat "$DOTFILES_DIR/lists/aurlist.txt"
fi

# Paso 3: Copiar configuraciones
echo "[3/6] Copiando configuraciones a ~/.config/..."
for item in "$DOTFILES_DIR"/config/*; do
    name=$(basename "$item")
    if [ -e "$HOME/.config/$name" ]; then
        echo "  Respaldando ~/.config/$name → ~/.config/${name}.bak"
        mv "$HOME/.config/$name" "$HOME/.config/${name}.bak"
    fi
    cp -r "$item" "$HOME/.config/$name"
    echo "  ✓ $name"
done

# Paso 4: Copiar scripts locales
echo "[4/6] Copiando scripts a ~/.local/bin/..."
mkdir -p "$HOME/.local/bin"
cp "$DOTFILES_DIR"/local-bin/*.sh "$HOME/.local/bin/"
chmod +x "$HOME/.local/bin"/*.sh
echo "  ✓ Scripts copiados"

# Paso 5: Copiar temas e iconos
echo "[5/6] Copiando temas e iconos..."
if [ -d "$DOTFILES_DIR/themes" ]; then
    cp -r "$DOTFILES_DIR/themes" "$HOME/.themes"
    echo "  ✓ Temas copiados"
fi
if [ -d "$DOTFILES_DIR/icons" ]; then
    cp -r "$DOTFILES_DIR/icons" "$HOME/.icons"
    echo "  ✓ Iconos copiados"
fi

# Paso 6: Habilitar servicios systemd de usuario
echo "[6/6] Habilitando servicios systemd..."
systemctl --user daemon-reload
for service in "$DOTFILES_DIR"/config/systemd/user/*.service; do
    name=$(basename "$service")
    systemctl --user enable "$name" 2>/dev/null && echo "  ✓ $name habilitado" || echo "  ⚠ $name no se pudo habilitar"
done

echo ""
echo "=== ✅ Restauración completada ==="
echo ""
echo "NOTAS:"
echo "  - Las fuentes (fonts) NO están incluidas. Cópialas manualmente a ~/.fonts/"
echo "  - Reinicia la sesión para que todos los cambios tomen efecto"
echo "  - Si usabas Hyprland, los plugins de hyprpm deben reinstalarse:"
echo "    hyprpm update && hyprpm add hyprland-plugins && hyprpm enable hyprbars"
