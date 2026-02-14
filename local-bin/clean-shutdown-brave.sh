#!/bin/bash
# Enviar señal de cierre limpio a Brave antes de apagar
if pgrep -x brave > /dev/null; then
    # Enviar SIGTERM (cierre limpio) y esperar hasta 10 segundos
    pkill -TERM -x brave
    for i in $(seq 1 10); do
        if ! pgrep -x brave > /dev/null; then
            break
        fi
        sleep 1
    done
fi
