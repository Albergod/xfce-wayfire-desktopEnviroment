#!/usr/bin/env bash
if [ -n "${WAYFIRE_SOCKET}" ] || [ "${XDG_SESSION_TYPE}" = "wayland" ]; then
  pkill -x xfdesktop 2>/dev/null || true
  pkill -x xfwm4 2>/dev/null || true
  xfconf-query -c xsettings -p /Gtk/CursorThemeName -s "Layan-border-cursors" >/dev/null 2>&1 || true
  xfconf-query -c xsettings -p /Gtk/CursorThemeSize -s 25 >/dev/null 2>&1 || true
  export XCURSOR_THEME="Layan-border-cursors"
  export XCURSOR_SIZE="25"
  systemctl --user import-environment XCURSOR_THEME XCURSOR_SIZE >/dev/null 2>&1 || true

  # Matar el daemon de Thunar para que al abrirlo cargue plugins limpiamente
  thunar --quit >/dev/null 2>&1 || true
fi
