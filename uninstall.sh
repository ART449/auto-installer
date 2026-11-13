#!/usr/bin/env bash
# ==============================================================================
# Auto-Installer — Script de Desinstalación
# ==============================================================================

set -euo pipefail

echo "Desinstalando Auto-Installer..."

rm -f "${HOME}/.local/bin/auto-installer"
rm -f "${HOME}/.local/share/applications/auto-installer.desktop"
rm -f "${HOME}/.local/share/icons/auto-installer.png"
rm -f "${HOME}/.local/share/icons/auto-installer.svg"
rm -f "${HOME}/.local/share/nautilus/scripts/⚡ Instalar o Desempaquetar"

if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database "${HOME}/.local/share/applications" 2>/dev/null || true
fi

echo "✔ Desinstalación completada."
