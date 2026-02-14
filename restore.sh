#!/bin/bash
# Script de restauración del entorno XFCE/Wayfire
# Compatible con cualquier distro basada en Arch (Arch, Manjaro, EndeavourOS, etc.)
# Uso: ./restore.sh

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Restauración del entorno XFCE/Wayfire ==="
echo ""

# Paso 1: Instalar paquetes oficiales
echo "[1/6] Instalando paquetes oficiales..."
sudo pacman -S --needed --noconfirm - < "$DOTFILES_DIR/lists/pkglist.txt" || echo "⚠ Algunos paquetes no se encontraron, continúa..."

# Paso 2: Instalar paquetes AUR
echo "[2/6] Instalando paquetes AUR..."
if command -v yay &>/dev/null; then
    yay -S --needed --noconfirm - < "$DOTFILES_DIR/lists/aurlist.txt" || echo "⚠ Algunos paquetes AUR fallaron"
elif command -v paru &>/dev/null; then
    paru -S --needed --noconfirm - < "$DOTFILES_DIR/lists/aurlist.txt" || echo "⚠ Algunos paquetes AUR fallaron"
else
    echo "⚠ No se encontró yay ni paru. Instálalos primero:"
    echo "   sudo pacman -S --needed git base-devel"
    echo "   git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si"
    echo ""
    echo "Luego instala manualmente:"
    cat "$DOTFILES_DIR/lists/aurlist.txt"
fi

# Paso 3: Copiar configuraciones
echo "[3/6] Copiando configuraciones a ~/.config/..."
mkdir -p "$HOME/.config"
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
mkdir -p "$HOME/.themes" "$HOME/.icons"
if [ -d "$DOTFILES_DIR/themes" ]; then
    cp -r "$DOTFILES_DIR"/themes/* "$HOME/.themes/"
    echo "  ✓ Temas copiados"
fi
if [ -d "$DOTFILES_DIR/icons" ]; then
    cp -r "$DOTFILES_DIR"/icons/* "$HOME/.icons/"
    echo "  ✓ Iconos copiados"
fi

# Paso 6: Habilitar servicios
echo "[6/6] Habilitando servicios..."
systemctl --user daemon-reload 2>/dev/null
for service in "$DOTFILES_DIR"/config/systemd/user/*.service; do
    [ -f "$service" ] || continue
    name=$(basename "$service")
    systemctl --user enable "$name" 2>/dev/null && echo "  ✓ $name" || echo "  ⚠ $name no se pudo habilitar"
done

# Habilitar lightdm
if command -v lightdm &>/dev/null; then
    sudo systemctl enable lightdm 2>/dev/null && echo "  ✓ lightdm habilitado" || echo "  ⚠ lightdm ya estaba habilitado o falló"
fi

echo ""
echo "=== ✅ Restauración completada ==="
echo ""
echo "NOTAS:"
echo "  - Las fuentes (fonts) NO están incluidas. Cópialas manualmente a ~/.fonts/"
echo "  - Reinicia la sesión para que todos los cambios tomen efecto"
echo "  - Verificar que lightdm esté habilitado: sudo systemctl enable lightdm"
