#!/bin/bash

# Script para lanzar el widget del sistema
# Guarda este archivo como ~/bin/launch-system-widget.sh y hazlo ejecutable

# Verificar si ya está ejecutándose
if pgrep -x "system-widget" >/dev/null; then
  # Si está corriendo, cerrarlo
  pkill -x "system-widget"
  exit 0
fi

# Si no está corriendo, iniciarlo
system-widget &
